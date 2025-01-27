(** This module analyzes function signatures to compute the
    hierarchy between regions.

    Note that we don't need to analyze the types: when there is a non-trivial
    relation between lifetimes in a type definition, the Rust compiler will
    automatically introduce the relevant where clauses. For instance, in the
    definition below:

    {[
      struct Wrapper<'a, 'b, T> {
        x : &'a mut &'b mut T,
      }
    ]}
    
    the Rust compiler will introduce the where clauses:
    {[
      'b : 'a
      T : 'b
    ]}

    However, it doesn't do so for the function signatures, which means we have
    to compute the constraints between the lifetimes ourselves, then that we
    have to compute the SCCs of the lifetimes (two lifetimes 'a and 'b may
    satisfy 'a : 'b and 'b : 'a, meaning they are actually equal and should
    be grouped together).

    TODO: we don't handle locally bound regions yet.
 *)

open Types
open TypesUtils
open Expressions
open LlbcAst
open LlbcAstUtils
open Assumed
open SCC
open Errors
module Subst = Substitute

(** The local logger *)
let log = Logging.regions_hierarchy_log

let compute_regions_hierarchy_for_sig (meta : Meta.meta option)
    (type_decls : type_decl TypeDeclId.Map.t)
    (fun_decls : fun_decl FunDeclId.Map.t)
    (global_decls : global_decl GlobalDeclId.Map.t)
    (trait_decls : trait_decl TraitDeclId.Map.t)
    (trait_impls : trait_impl TraitImplId.Map.t) (fun_name : string)
    (sg : fun_sig) : region_var_groups =
  log#ldebug (lazy (__FUNCTION__ ^ ": " ^ fun_name));
  (* Initialize a normalization context (we may need to normalize some
     associated types) *)
  let norm_ctx : AssociatedTypes.norm_ctx =
    let norm_trait_types =
      AssociatedTypes.compute_norm_trait_types_from_preds meta
        sg.preds.trait_type_constraints
    in
    {
      meta;
      norm_trait_types;
      type_decls;
      fun_decls;
      global_decls;
      trait_decls;
      trait_impls;
      type_vars = sg.generics.types;
      const_generic_vars = sg.generics.const_generics;
    }
  in

  (* Create the dependency graph.

     An edge from 'short to 'long means that 'long outlives 'short (that is
     we have 'long : 'short,  using Rust notations).
  *)
  (* First initialize the regions map.

     We add:
     - the region variables
     - the static region
     - edges from the region variables to the static region

     Note that we introduce free variables for all the regions bound at the
     level of the signature (this excludes the regions locally bound inside
     the types, for instance at the level of an arrow type).
  *)
  let bound_regions, bound_regions_id_subst, bound_regions_subst =
    Subst.fresh_regions_with_substs_from_vars ~fail_if_not_found:true
      sg.generics.regions
  in
  let region_id_to_var_map : RegionVarId.id RegionId.Map.t =
    RegionId.Map.of_list
      (List.combine bound_regions
         (List.map (fun (r : region_var) -> r.index) sg.generics.regions))
  in
  let subst = { Subst.empty_subst with r_subst = bound_regions_subst } in
  let g : RegionSet.t RegionMap.t ref =
    let s_set = RegionSet.singleton RStatic in
    let m =
      List.map
        (fun (r : region_var) ->
          (RFVar (Option.get (bound_regions_id_subst r.index)), s_set))
        sg.generics.regions
    in
    let s = (RStatic, RegionSet.empty) in
    ref (RegionMap.of_list (s :: m))
  in

  let add_edge ~(short : region) ~(long : region) =
    (* Sanity checks *)
    sanity_check_opt_meta __FILE__ __LINE__ (short <> RErased) meta;
    sanity_check_opt_meta __FILE__ __LINE__ (long <> RErased) meta;
    (* Ignore the locally bound regions (at the level of arrow types for instance *)
    match (short, long) with
    | RBVar _, _ | _, RBVar _ -> ()
    | _, _ ->
        let m = !g in
        let s = RegionMap.find short !g in
        let s = RegionSet.add long s in
        g := RegionMap.add short s m
  in

  let add_edge_from_region_constraint ((long, short) : region_outlives) =
    add_edge ~short ~long
  in

  let add_edges ~(long : region) ~(shorts : region list) =
    List.iter (fun short -> add_edge ~short ~long) shorts
  in

  (* Explore the clauses - we only explore the "region outlives" clause,
     not the "type outlives" clauses *)
  List.iter add_edge_from_region_constraint sg.preds.regions_outlive;

  (* Explore the types in the signature to add the edges *)
  let rec explore_ty (outer : region list) (ty : ty) =
    match ty with
    | TAdt (id, generics) ->
        (* Add constraints coming from the type clauses *)
        (match id with
        | TAdtId id ->
            (* Lookup the type declaration *)
            let decl = TypeDeclId.Map.find id type_decls in
            (* Instantiate the predicates *)
            let tr_self =
              UnknownTrait ("Unexpected, introduced by " ^ __FUNCTION__)
            in
            let subst =
              Subst.make_subst_from_generics decl.generics generics tr_self
            in
            let predicates = Subst.predicates_substitute subst decl.preds in
            (* Note that because we also explore the generics below, we may
               explore several times the same type - this is ok *)
            List.iter
              (fun (long, short) -> add_edges ~long ~shorts:(short :: outer))
              predicates.regions_outlive;
            List.iter
              (fun (ty, short) -> explore_ty (short :: outer) ty)
              predicates.types_outlive
        | TTuple -> (* No clauses for tuples *) ()
        | TAssumed aid -> (
            match aid with
            | TBox | TArray | TSlice | TStr -> (* No clauses for those *) ()));
        (* Explore the generics *)
        explore_generics outer generics
    | TVar _ | TLiteral _ | TNever -> ()
    | TRef (r, ty, _) ->
        (* Add the constraints for r *)
        add_edges ~long:r ~shorts:outer;
        (* Add r to the outer regions *)
        let outer = r :: outer in
        (* Continue *)
        explore_ty outer ty
    | TRawPtr (ty, _) -> explore_ty outer ty
    | TTraitType (trait_ref, _) ->
        (* The trait should reference a clause, and not an implementation
           (otherwise it should have been normalized) *)
        sanity_check_opt_meta __FILE__ __LINE__
          (AssociatedTypes.trait_instance_id_is_local_clause trait_ref.trait_id)
          meta;
        (* We have nothing to do *)
        ()
    | TArrow (regions, inputs, output) ->
        (* TODO: *)
        cassert_opt_meta __FILE__ __LINE__ (regions = []) meta
          "We don't support arrow types with locally quantified regions";
        (* We can ignore the outer regions *)
        List.iter (explore_ty []) (output :: inputs)
  and explore_generics (outer : region list) (generics : generic_args) =
    let { regions; types; const_generics = _; trait_refs = _ } = generics in
    List.iter (fun long -> add_edges ~long ~shorts:outer) regions;
    List.iter (explore_ty outer) types
  in

  (* Substitute the regions in a type, then explore *)
  let explore_ty_subst ty =
    let ty = Subst.ty_substitute subst ty in
    explore_ty [] ty
  in

  (* Normalize the types then explore *)
  let tys =
    List.map
      (AssociatedTypes.norm_ctx_normalize_ty norm_ctx)
      (sg.output :: sg.inputs)
  in
  List.iter explore_ty_subst tys;

  (* Compute the ordered SCCs *)
  let module Scc = SCC.Make (RegionOrderedType) in
  let sccs = Scc.compute (RegionMap.bindings !g) in

  (* Remove the SCC containing the static region.

     For now, we don't handle cases where regions different from 'static
     can live as long as 'static, so we check that if the group contains
     'static then it is the only region it contains, and then we filter
     the group.
     TODO: general support for 'static
  *)
  let sccs =
    (* Find the SCC which contains the static region *)
    let static_gr_id, static_scc =
      List.find
        (fun (_, scc) -> List.mem RStatic scc)
        (SccId.Map.bindings sccs.sccs)
    in
    (* The SCC should only contain the 'static *)
    sanity_check_opt_meta __FILE__ __LINE__ (static_scc = [ RStatic ]) meta;
    (* Remove the group as well as references to this group from the
       other SCCs *)
    let { sccs; scc_deps } = sccs in
    (* We have to change the indexing:
       - if id < static_gr_id: we leave the id as it is
       - if id = static_gr_id: we remove id
       - if id > static_gr_id: we decrement it by one
    *)
    let static_i = SccId.to_int static_gr_id in
    let convert_id (id : SccId.id) : SccId.id option =
      let i = SccId.to_int id in
      if i < static_i then Some id
      else if i = static_i then None
      else Some (SccId.of_int (i - 1))
    in
    let sccs =
      SccId.Map.of_list
        (List.filter_map
           (fun (id, rg_ids) ->
             match convert_id id with
             | None -> None
             | Some id -> Some (id, rg_ids))
           (SccId.Map.bindings sccs))
    in

    let scc_deps =
      List.filter_map
        (fun (id, deps) ->
          match convert_id id with
          | None -> None
          | Some id ->
              let deps = List.filter_map convert_id (SccId.Set.elements deps) in
              Some (id, SccId.Set.of_list deps))
        (SccId.Map.bindings scc_deps)
    in
    let scc_deps = SccId.Map.of_list scc_deps in

    { sccs; scc_deps }
  in

  (*
   * Compute the regions hierarchy
   *)
  List.filter_map
    (fun (scc_id, scc) ->
      (* The region id *)
      let i = SccId.to_int scc_id in
      let id = RegionGroupId.of_int i in

      (* Retrieve the set of regions in the group *)
      let regions : RegionVarId.id list =
        List.map
          (fun r ->
            match r with
            | RFVar rid -> RegionId.Map.find rid region_id_to_var_map
            | _ -> craise __FILE__ __LINE__ (Option.get meta) "Unreachable")
          scc
      in

      (* Compute the set of parent region groups *)
      let parents =
        List.map
          (fun id -> RegionGroupId.of_int (SccId.to_int id))
          (SccId.Set.elements (SccId.Map.find scc_id sccs.scc_deps))
      in

      (* Put together *)
      Some { id; regions; parents })
    (SccId.Map.bindings sccs.sccs)

let compute_regions_hierarchies (type_decls : type_decl TypeDeclId.Map.t)
    (fun_decls : fun_decl FunDeclId.Map.t)
    (global_decls : global_decl GlobalDeclId.Map.t)
    (trait_decls : trait_decl TraitDeclId.Map.t)
    (trait_impls : trait_impl TraitImplId.Map.t) : region_var_groups FunIdMap.t
    =
  let open Print in
  let env : fmt_env =
    {
      type_decls;
      fun_decls;
      global_decls;
      trait_decls;
      trait_impls;
      regions = [];
      types = [];
      const_generics = [];
      trait_clauses = [];
      preds = empty_predicates;
      locals = [];
    }
  in
  let regular =
    List.map
      (fun ((fid, d) : FunDeclId.id * fun_decl) ->
        ( FRegular fid,
          (Types.name_to_string env d.name, d.signature, Some d.item_meta.meta)
        ))
      (FunDeclId.Map.bindings fun_decls)
  in
  let assumed =
    List.map
      (fun (info : assumed_fun_info) ->
        (FAssumed info.fun_id, (info.name, info.fun_sig, None)))
      assumed_fun_infos
  in
  FunIdMap.of_list
    (List.map
       (fun (fid, (name, sg, meta)) ->
         ( fid,
           compute_regions_hierarchy_for_sig meta type_decls fun_decls
             global_decls trait_decls trait_impls name sg ))
       (regular @ assumed))
