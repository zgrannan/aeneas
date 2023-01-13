(** THIS FILE WAS AUTOMATICALLY GENERATED BY AENEAS *)
(** [hashmap_main]: function definitions *)
Require Import Primitives.
Import Primitives.
Require Import Coq.ZArith.ZArith.
Local Open Scope Primitives_scope.
Require Export HashmapMain_Types.
Import HashmapMain_Types.
Require Export HashmapMain_Opaque.
Import HashmapMain_Opaque.
Module HashmapMain_Funs.

(** [hashmap_main::hashmap::hash_key] *)
Definition hashmap_hash_key_fwd (k : usize) : result usize := Return k.

(** [hashmap_main::hashmap::HashMap::{0}::allocate_slots] *)
Fixpoint hashmap_hash_map_allocate_slots_loop_fwd
  (T : Type) (n : nat) (slots : vec (Hashmap_list_t T)) (n0 : usize) :
  result (vec (Hashmap_list_t T))
  :=
  match n with
  | O => Fail_ OutOfFuel
  | S n1 =>
    if n0 s> 0%usize
    then (
      slots0 <- vec_push_back (Hashmap_list_t T) slots HashmapListNil;
      n2 <- usize_sub n0 1%usize;
      hashmap_hash_map_allocate_slots_loop_fwd T n1 slots0 n2)
    else Return slots
  end
.

(** [hashmap_main::hashmap::HashMap::{0}::allocate_slots] *)
Definition hashmap_hash_map_allocate_slots_fwd
  (T : Type) (n : nat) (slots : vec (Hashmap_list_t T)) (n0 : usize) :
  result (vec (Hashmap_list_t T))
  :=
  hashmap_hash_map_allocate_slots_loop_fwd T n slots n0
.

(** [hashmap_main::hashmap::HashMap::{0}::new_with_capacity] *)
Definition hashmap_hash_map_new_with_capacity_fwd
  (T : Type) (n : nat) (capacity : usize) (max_load_dividend : usize)
  (max_load_divisor : usize) :
  result (Hashmap_hash_map_t T)
  :=
  let v := vec_new (Hashmap_list_t T) in
  slots <- hashmap_hash_map_allocate_slots_fwd T n v capacity;
  i <- usize_mul capacity max_load_dividend;
  i0 <- usize_div i max_load_divisor;
  Return (mkHashmap_hash_map_t (0%usize) (max_load_dividend, max_load_divisor)
    i0 slots)
.

(** [hashmap_main::hashmap::HashMap::{0}::new] *)
Definition hashmap_hash_map_new_fwd
  (T : Type) (n : nat) : result (Hashmap_hash_map_t T) :=
  hashmap_hash_map_new_with_capacity_fwd T n (32%usize) (4%usize) (5%usize)
.

(** [hashmap_main::hashmap::HashMap::{0}::clear_slots] *)
Fixpoint hashmap_hash_map_clear_slots_loop_fwd_back
  (T : Type) (n : nat) (slots : vec (Hashmap_list_t T)) (i : usize) :
  result (vec (Hashmap_list_t T))
  :=
  match n with
  | O => Fail_ OutOfFuel
  | S n0 =>
    let i0 := vec_len (Hashmap_list_t T) slots in
    if i s< i0
    then (
      i1 <- usize_add i 1%usize;
      slots0 <- vec_index_mut_back (Hashmap_list_t T) slots i HashmapListNil;
      hashmap_hash_map_clear_slots_loop_fwd_back T n0 slots0 i1)
    else Return slots
  end
.

(** [hashmap_main::hashmap::HashMap::{0}::clear_slots] *)
Definition hashmap_hash_map_clear_slots_fwd_back
  (T : Type) (n : nat) (slots : vec (Hashmap_list_t T)) :
  result (vec (Hashmap_list_t T))
  :=
  hashmap_hash_map_clear_slots_loop_fwd_back T n slots (0%usize)
.

(** [hashmap_main::hashmap::HashMap::{0}::clear] *)
Definition hashmap_hash_map_clear_fwd_back
  (T : Type) (n : nat) (self : Hashmap_hash_map_t T) :
  result (Hashmap_hash_map_t T)
  :=
  v <- hashmap_hash_map_clear_slots_fwd_back T n self.(Hashmap_hash_map_slots);
  Return (mkHashmap_hash_map_t (0%usize)
    self.(Hashmap_hash_map_max_load_factor) self.(Hashmap_hash_map_max_load) v)
.

(** [hashmap_main::hashmap::HashMap::{0}::len] *)
Definition hashmap_hash_map_len_fwd
  (T : Type) (self : Hashmap_hash_map_t T) : result usize :=
  Return self.(Hashmap_hash_map_num_entries)
.

(** [hashmap_main::hashmap::HashMap::{0}::insert_in_list] *)
Fixpoint hashmap_hash_map_insert_in_list_loop_fwd
  (T : Type) (n : nat) (key : usize) (value : T) (ls : Hashmap_list_t T) :
  result bool
  :=
  match n with
  | O => Fail_ OutOfFuel
  | S n0 =>
    match ls with
    | HashmapListCons ckey cvalue tl =>
      if ckey s= key
      then Return false
      else hashmap_hash_map_insert_in_list_loop_fwd T n0 key value tl
    | HashmapListNil => Return true
    end
  end
.

(** [hashmap_main::hashmap::HashMap::{0}::insert_in_list] *)
Definition hashmap_hash_map_insert_in_list_fwd
  (T : Type) (n : nat) (key : usize) (value : T) (ls : Hashmap_list_t T) :
  result bool
  :=
  hashmap_hash_map_insert_in_list_loop_fwd T n key value ls
.

(** [hashmap_main::hashmap::HashMap::{0}::insert_in_list] *)
Fixpoint hashmap_hash_map_insert_in_list_loop_back
  (T : Type) (n : nat) (key : usize) (value : T) (ls : Hashmap_list_t T) :
  result (Hashmap_list_t T)
  :=
  match n with
  | O => Fail_ OutOfFuel
  | S n0 =>
    match ls with
    | HashmapListCons ckey cvalue tl =>
      if ckey s= key
      then Return (HashmapListCons ckey value tl)
      else (
        tl0 <- hashmap_hash_map_insert_in_list_loop_back T n0 key value tl;
        Return (HashmapListCons ckey cvalue tl0))
    | HashmapListNil =>
      let l := HashmapListNil in Return (HashmapListCons key value l)
    end
  end
.

(** [hashmap_main::hashmap::HashMap::{0}::insert_in_list] *)
Definition hashmap_hash_map_insert_in_list_back
  (T : Type) (n : nat) (key : usize) (value : T) (ls : Hashmap_list_t T) :
  result (Hashmap_list_t T)
  :=
  hashmap_hash_map_insert_in_list_loop_back T n key value ls
.

(** [hashmap_main::hashmap::HashMap::{0}::insert_no_resize] *)
Definition hashmap_hash_map_insert_no_resize_fwd_back
  (T : Type) (n : nat) (self : Hashmap_hash_map_t T) (key : usize) (value : T)
  :
  result (Hashmap_hash_map_t T)
  :=
  hash <- hashmap_hash_key_fwd key;
  let i := vec_len (Hashmap_list_t T) self.(Hashmap_hash_map_slots) in
  hash_mod <- usize_rem hash i;
  l <-
    vec_index_mut_fwd (Hashmap_list_t T) self.(Hashmap_hash_map_slots) hash_mod;
  inserted <- hashmap_hash_map_insert_in_list_fwd T n key value l;
  if inserted
  then (
    i0 <- usize_add self.(Hashmap_hash_map_num_entries) 1%usize;
    l0 <- hashmap_hash_map_insert_in_list_back T n key value l;
    v <-
      vec_index_mut_back (Hashmap_list_t T) self.(Hashmap_hash_map_slots)
        hash_mod l0;
    Return (mkHashmap_hash_map_t i0 self.(Hashmap_hash_map_max_load_factor)
      self.(Hashmap_hash_map_max_load) v))
  else (
    l0 <- hashmap_hash_map_insert_in_list_back T n key value l;
    v <-
      vec_index_mut_back (Hashmap_list_t T) self.(Hashmap_hash_map_slots)
        hash_mod l0;
    Return (mkHashmap_hash_map_t self.(Hashmap_hash_map_num_entries)
      self.(Hashmap_hash_map_max_load_factor) self.(Hashmap_hash_map_max_load)
      v))
.

(** [core::num::u32::{9}::MAX] *)
Definition core_num_u32_max_body : result u32 := Return (4294967295%u32).
Definition core_num_u32_max_c : u32 := core_num_u32_max_body%global.

(** [hashmap_main::hashmap::HashMap::{0}::move_elements_from_list] *)
Fixpoint hashmap_hash_map_move_elements_from_list_loop_fwd_back
  (T : Type) (n : nat) (ntable : Hashmap_hash_map_t T) (ls : Hashmap_list_t T)
  :
  result (Hashmap_hash_map_t T)
  :=
  match n with
  | O => Fail_ OutOfFuel
  | S n0 =>
    match ls with
    | HashmapListCons k v tl =>
      ntable0 <- hashmap_hash_map_insert_no_resize_fwd_back T n0 ntable k v;
      hashmap_hash_map_move_elements_from_list_loop_fwd_back T n0 ntable0 tl
    | HashmapListNil => Return ntable
    end
  end
.

(** [hashmap_main::hashmap::HashMap::{0}::move_elements_from_list] *)
Definition hashmap_hash_map_move_elements_from_list_fwd_back
  (T : Type) (n : nat) (ntable : Hashmap_hash_map_t T) (ls : Hashmap_list_t T)
  :
  result (Hashmap_hash_map_t T)
  :=
  hashmap_hash_map_move_elements_from_list_loop_fwd_back T n ntable ls
.

(** [hashmap_main::hashmap::HashMap::{0}::move_elements] *)
Fixpoint hashmap_hash_map_move_elements_loop_fwd_back
  (T : Type) (n : nat) (ntable : Hashmap_hash_map_t T)
  (slots : vec (Hashmap_list_t T)) (i : usize) :
  result ((Hashmap_hash_map_t T) * (vec (Hashmap_list_t T)))
  :=
  match n with
  | O => Fail_ OutOfFuel
  | S n0 =>
    let i0 := vec_len (Hashmap_list_t T) slots in
    if i s< i0
    then (
      l <- vec_index_mut_fwd (Hashmap_list_t T) slots i;
      let ls := mem_replace_fwd (Hashmap_list_t T) l HashmapListNil in
      ntable0 <-
        hashmap_hash_map_move_elements_from_list_fwd_back T n0 ntable ls;
      i1 <- usize_add i 1%usize;
      let l0 := mem_replace_back (Hashmap_list_t T) l HashmapListNil in
      slots0 <- vec_index_mut_back (Hashmap_list_t T) slots i l0;
      hashmap_hash_map_move_elements_loop_fwd_back T n0 ntable0 slots0 i1)
    else Return (ntable, slots)
  end
.

(** [hashmap_main::hashmap::HashMap::{0}::move_elements] *)
Definition hashmap_hash_map_move_elements_fwd_back
  (T : Type) (n : nat) (ntable : Hashmap_hash_map_t T)
  (slots : vec (Hashmap_list_t T)) (i : usize) :
  result ((Hashmap_hash_map_t T) * (vec (Hashmap_list_t T)))
  :=
  hashmap_hash_map_move_elements_loop_fwd_back T n ntable slots i
.

(** [hashmap_main::hashmap::HashMap::{0}::try_resize] *)
Definition hashmap_hash_map_try_resize_fwd_back
  (T : Type) (n : nat) (self : Hashmap_hash_map_t T) :
  result (Hashmap_hash_map_t T)
  :=
  max_usize <- scalar_cast U32 Usize core_num_u32_max_c;
  let capacity := vec_len (Hashmap_list_t T) self.(Hashmap_hash_map_slots) in
  n1 <- usize_div max_usize 2%usize;
  let (i, i0) := self.(Hashmap_hash_map_max_load_factor) in
  i1 <- usize_div n1 i;
  if capacity s<= i1
  then (
    i2 <- usize_mul capacity 2%usize;
    ntable <- hashmap_hash_map_new_with_capacity_fwd T n i2 i i0;
    p <-
      hashmap_hash_map_move_elements_fwd_back T n ntable
        self.(Hashmap_hash_map_slots) (0%usize);
    let (ntable0, _) := p in
    Return (mkHashmap_hash_map_t self.(Hashmap_hash_map_num_entries) (i, i0)
      ntable0.(Hashmap_hash_map_max_load) ntable0.(Hashmap_hash_map_slots)))
  else
    Return (mkHashmap_hash_map_t self.(Hashmap_hash_map_num_entries) (i, i0)
      self.(Hashmap_hash_map_max_load) self.(Hashmap_hash_map_slots))
.

(** [hashmap_main::hashmap::HashMap::{0}::insert] *)
Definition hashmap_hash_map_insert_fwd_back
  (T : Type) (n : nat) (self : Hashmap_hash_map_t T) (key : usize) (value : T)
  :
  result (Hashmap_hash_map_t T)
  :=
  self0 <- hashmap_hash_map_insert_no_resize_fwd_back T n self key value;
  i <- hashmap_hash_map_len_fwd T self0;
  if i s> self0.(Hashmap_hash_map_max_load)
  then hashmap_hash_map_try_resize_fwd_back T n self0
  else Return self0
.

(** [hashmap_main::hashmap::HashMap::{0}::contains_key_in_list] *)
Fixpoint hashmap_hash_map_contains_key_in_list_loop_fwd
  (T : Type) (n : nat) (key : usize) (ls : Hashmap_list_t T) : result bool :=
  match n with
  | O => Fail_ OutOfFuel
  | S n0 =>
    match ls with
    | HashmapListCons ckey t tl =>
      if ckey s= key
      then Return true
      else hashmap_hash_map_contains_key_in_list_loop_fwd T n0 key tl
    | HashmapListNil => Return false
    end
  end
.

(** [hashmap_main::hashmap::HashMap::{0}::contains_key_in_list] *)
Definition hashmap_hash_map_contains_key_in_list_fwd
  (T : Type) (n : nat) (key : usize) (ls : Hashmap_list_t T) : result bool :=
  hashmap_hash_map_contains_key_in_list_loop_fwd T n key ls
.

(** [hashmap_main::hashmap::HashMap::{0}::contains_key] *)
Definition hashmap_hash_map_contains_key_fwd
  (T : Type) (n : nat) (self : Hashmap_hash_map_t T) (key : usize) :
  result bool
  :=
  hash <- hashmap_hash_key_fwd key;
  let i := vec_len (Hashmap_list_t T) self.(Hashmap_hash_map_slots) in
  hash_mod <- usize_rem hash i;
  l <- vec_index_fwd (Hashmap_list_t T) self.(Hashmap_hash_map_slots) hash_mod;
  hashmap_hash_map_contains_key_in_list_fwd T n key l
.

(** [hashmap_main::hashmap::HashMap::{0}::get_in_list] *)
Fixpoint hashmap_hash_map_get_in_list_loop_fwd
  (T : Type) (n : nat) (key : usize) (ls : Hashmap_list_t T) : result T :=
  match n with
  | O => Fail_ OutOfFuel
  | S n0 =>
    match ls with
    | HashmapListCons ckey cvalue tl =>
      if ckey s= key
      then Return cvalue
      else hashmap_hash_map_get_in_list_loop_fwd T n0 key tl
    | HashmapListNil => Fail_ Failure
    end
  end
.

(** [hashmap_main::hashmap::HashMap::{0}::get_in_list] *)
Definition hashmap_hash_map_get_in_list_fwd
  (T : Type) (n : nat) (key : usize) (ls : Hashmap_list_t T) : result T :=
  hashmap_hash_map_get_in_list_loop_fwd T n key ls
.

(** [hashmap_main::hashmap::HashMap::{0}::get] *)
Definition hashmap_hash_map_get_fwd
  (T : Type) (n : nat) (self : Hashmap_hash_map_t T) (key : usize) :
  result T
  :=
  hash <- hashmap_hash_key_fwd key;
  let i := vec_len (Hashmap_list_t T) self.(Hashmap_hash_map_slots) in
  hash_mod <- usize_rem hash i;
  l <- vec_index_fwd (Hashmap_list_t T) self.(Hashmap_hash_map_slots) hash_mod;
  hashmap_hash_map_get_in_list_fwd T n key l
.

(** [hashmap_main::hashmap::HashMap::{0}::get_mut_in_list] *)
Fixpoint hashmap_hash_map_get_mut_in_list_loop_fwd
  (T : Type) (n : nat) (ls : Hashmap_list_t T) (key : usize) : result T :=
  match n with
  | O => Fail_ OutOfFuel
  | S n0 =>
    match ls with
    | HashmapListCons ckey cvalue tl =>
      if ckey s= key
      then Return cvalue
      else hashmap_hash_map_get_mut_in_list_loop_fwd T n0 tl key
    | HashmapListNil => Fail_ Failure
    end
  end
.

(** [hashmap_main::hashmap::HashMap::{0}::get_mut_in_list] *)
Definition hashmap_hash_map_get_mut_in_list_fwd
  (T : Type) (n : nat) (ls : Hashmap_list_t T) (key : usize) : result T :=
  hashmap_hash_map_get_mut_in_list_loop_fwd T n ls key
.

(** [hashmap_main::hashmap::HashMap::{0}::get_mut_in_list] *)
Fixpoint hashmap_hash_map_get_mut_in_list_loop_back
  (T : Type) (n : nat) (ls : Hashmap_list_t T) (key : usize) (ret : T) :
  result (Hashmap_list_t T)
  :=
  match n with
  | O => Fail_ OutOfFuel
  | S n0 =>
    match ls with
    | HashmapListCons ckey cvalue tl =>
      if ckey s= key
      then Return (HashmapListCons ckey ret tl)
      else (
        tl0 <- hashmap_hash_map_get_mut_in_list_loop_back T n0 tl key ret;
        Return (HashmapListCons ckey cvalue tl0))
    | HashmapListNil => Fail_ Failure
    end
  end
.

(** [hashmap_main::hashmap::HashMap::{0}::get_mut_in_list] *)
Definition hashmap_hash_map_get_mut_in_list_back
  (T : Type) (n : nat) (ls : Hashmap_list_t T) (key : usize) (ret : T) :
  result (Hashmap_list_t T)
  :=
  hashmap_hash_map_get_mut_in_list_loop_back T n ls key ret
.

(** [hashmap_main::hashmap::HashMap::{0}::get_mut] *)
Definition hashmap_hash_map_get_mut_fwd
  (T : Type) (n : nat) (self : Hashmap_hash_map_t T) (key : usize) :
  result T
  :=
  hash <- hashmap_hash_key_fwd key;
  let i := vec_len (Hashmap_list_t T) self.(Hashmap_hash_map_slots) in
  hash_mod <- usize_rem hash i;
  l <-
    vec_index_mut_fwd (Hashmap_list_t T) self.(Hashmap_hash_map_slots) hash_mod;
  hashmap_hash_map_get_mut_in_list_fwd T n l key
.

(** [hashmap_main::hashmap::HashMap::{0}::get_mut] *)
Definition hashmap_hash_map_get_mut_back
  (T : Type) (n : nat) (self : Hashmap_hash_map_t T) (key : usize) (ret : T) :
  result (Hashmap_hash_map_t T)
  :=
  hash <- hashmap_hash_key_fwd key;
  let i := vec_len (Hashmap_list_t T) self.(Hashmap_hash_map_slots) in
  hash_mod <- usize_rem hash i;
  l <-
    vec_index_mut_fwd (Hashmap_list_t T) self.(Hashmap_hash_map_slots) hash_mod;
  l0 <- hashmap_hash_map_get_mut_in_list_back T n l key ret;
  v <-
    vec_index_mut_back (Hashmap_list_t T) self.(Hashmap_hash_map_slots)
      hash_mod l0;
  Return (mkHashmap_hash_map_t self.(Hashmap_hash_map_num_entries)
    self.(Hashmap_hash_map_max_load_factor) self.(Hashmap_hash_map_max_load) v)
.

(** [hashmap_main::hashmap::HashMap::{0}::remove_from_list] *)
Fixpoint hashmap_hash_map_remove_from_list_loop_fwd
  (T : Type) (n : nat) (key : usize) (ls : Hashmap_list_t T) :
  result (option T)
  :=
  match n with
  | O => Fail_ OutOfFuel
  | S n0 =>
    match ls with
    | HashmapListCons ckey t tl =>
      if ckey s= key
      then
        let mv_ls :=
          mem_replace_fwd (Hashmap_list_t T) (HashmapListCons ckey t tl)
            HashmapListNil in
        match mv_ls with
        | HashmapListCons i cvalue tl0 => Return (Some cvalue)
        | HashmapListNil => Fail_ Failure
        end
      else hashmap_hash_map_remove_from_list_loop_fwd T n0 key tl
    | HashmapListNil => Return None
    end
  end
.

(** [hashmap_main::hashmap::HashMap::{0}::remove_from_list] *)
Definition hashmap_hash_map_remove_from_list_fwd
  (T : Type) (n : nat) (key : usize) (ls : Hashmap_list_t T) :
  result (option T)
  :=
  hashmap_hash_map_remove_from_list_loop_fwd T n key ls
.

(** [hashmap_main::hashmap::HashMap::{0}::remove_from_list] *)
Fixpoint hashmap_hash_map_remove_from_list_loop_back
  (T : Type) (n : nat) (key : usize) (ls : Hashmap_list_t T) :
  result (Hashmap_list_t T)
  :=
  match n with
  | O => Fail_ OutOfFuel
  | S n0 =>
    match ls with
    | HashmapListCons ckey t tl =>
      if ckey s= key
      then
        let mv_ls :=
          mem_replace_fwd (Hashmap_list_t T) (HashmapListCons ckey t tl)
            HashmapListNil in
        match mv_ls with
        | HashmapListCons i cvalue tl0 => Return tl0
        | HashmapListNil => Fail_ Failure
        end
      else (
        tl0 <- hashmap_hash_map_remove_from_list_loop_back T n0 key tl;
        Return (HashmapListCons ckey t tl0))
    | HashmapListNil => Return HashmapListNil
    end
  end
.

(** [hashmap_main::hashmap::HashMap::{0}::remove_from_list] *)
Definition hashmap_hash_map_remove_from_list_back
  (T : Type) (n : nat) (key : usize) (ls : Hashmap_list_t T) :
  result (Hashmap_list_t T)
  :=
  hashmap_hash_map_remove_from_list_loop_back T n key ls
.

(** [hashmap_main::hashmap::HashMap::{0}::remove] *)
Definition hashmap_hash_map_remove_fwd
  (T : Type) (n : nat) (self : Hashmap_hash_map_t T) (key : usize) :
  result (option T)
  :=
  hash <- hashmap_hash_key_fwd key;
  let i := vec_len (Hashmap_list_t T) self.(Hashmap_hash_map_slots) in
  hash_mod <- usize_rem hash i;
  l <-
    vec_index_mut_fwd (Hashmap_list_t T) self.(Hashmap_hash_map_slots) hash_mod;
  x <- hashmap_hash_map_remove_from_list_fwd T n key l;
  match x with
  | None => Return None
  | Some x0 =>
    _ <- usize_sub self.(Hashmap_hash_map_num_entries) 1%usize;
    Return (Some x0)
  end
.

(** [hashmap_main::hashmap::HashMap::{0}::remove] *)
Definition hashmap_hash_map_remove_back
  (T : Type) (n : nat) (self : Hashmap_hash_map_t T) (key : usize) :
  result (Hashmap_hash_map_t T)
  :=
  hash <- hashmap_hash_key_fwd key;
  let i := vec_len (Hashmap_list_t T) self.(Hashmap_hash_map_slots) in
  hash_mod <- usize_rem hash i;
  l <-
    vec_index_mut_fwd (Hashmap_list_t T) self.(Hashmap_hash_map_slots) hash_mod;
  x <- hashmap_hash_map_remove_from_list_fwd T n key l;
  match x with
  | None =>
    l0 <- hashmap_hash_map_remove_from_list_back T n key l;
    v <-
      vec_index_mut_back (Hashmap_list_t T) self.(Hashmap_hash_map_slots)
        hash_mod l0;
    Return (mkHashmap_hash_map_t self.(Hashmap_hash_map_num_entries)
      self.(Hashmap_hash_map_max_load_factor) self.(Hashmap_hash_map_max_load)
      v)
  | Some x0 =>
    i0 <- usize_sub self.(Hashmap_hash_map_num_entries) 1%usize;
    l0 <- hashmap_hash_map_remove_from_list_back T n key l;
    v <-
      vec_index_mut_back (Hashmap_list_t T) self.(Hashmap_hash_map_slots)
        hash_mod l0;
    Return (mkHashmap_hash_map_t i0 self.(Hashmap_hash_map_max_load_factor)
      self.(Hashmap_hash_map_max_load) v)
  end
.

(** [hashmap_main::hashmap::test1] *)
Definition hashmap_test1_fwd (n : nat) : result unit :=
  hm <- hashmap_hash_map_new_fwd u64 n;
  hm0 <- hashmap_hash_map_insert_fwd_back u64 n hm (0%usize) (42%u64);
  hm1 <- hashmap_hash_map_insert_fwd_back u64 n hm0 (128%usize) (18%u64);
  hm2 <- hashmap_hash_map_insert_fwd_back u64 n hm1 (1024%usize) (138%u64);
  hm3 <- hashmap_hash_map_insert_fwd_back u64 n hm2 (1056%usize) (256%u64);
  i <- hashmap_hash_map_get_fwd u64 n hm3 (128%usize);
  if negb (i s= 18%u64)
  then Fail_ Failure
  else (
    hm4 <- hashmap_hash_map_get_mut_back u64 n hm3 (1024%usize) (56%u64);
    i0 <- hashmap_hash_map_get_fwd u64 n hm4 (1024%usize);
    if negb (i0 s= 56%u64)
    then Fail_ Failure
    else (
      x <- hashmap_hash_map_remove_fwd u64 n hm4 (1024%usize);
      match x with
      | None => Fail_ Failure
      | Some x0 =>
        if negb (x0 s= 56%u64)
        then Fail_ Failure
        else (
          hm5 <- hashmap_hash_map_remove_back u64 n hm4 (1024%usize);
          i1 <- hashmap_hash_map_get_fwd u64 n hm5 (0%usize);
          if negb (i1 s= 42%u64)
          then Fail_ Failure
          else (
            i2 <- hashmap_hash_map_get_fwd u64 n hm5 (128%usize);
            if negb (i2 s= 18%u64)
            then Fail_ Failure
            else (
              i3 <- hashmap_hash_map_get_fwd u64 n hm5 (1056%usize);
              if negb (i3 s= 256%u64) then Fail_ Failure else Return tt)))
      end))
.

(** [hashmap_main::insert_on_disk] *)
Definition insert_on_disk_fwd
  (n : nat) (key : usize) (value : u64) (st : state) : result (state * unit) :=
  p <- hashmap_utils_deserialize_fwd st;
  let (st0, hm) := p in
  hm0 <- hashmap_hash_map_insert_fwd_back u64 n hm key value;
  p0 <- hashmap_utils_serialize_fwd hm0 st0;
  let (st1, _) := p0 in
  Return (st1, tt)
.

(** [hashmap_main::main] *)
Definition main_fwd : result unit := Return tt.

(** Unit test for [hashmap_main::main] *)
Check (main_fwd )%return.

End HashmapMain_Funs .
