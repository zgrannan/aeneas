(** THIS FILE WAS AUTOMATICALLY GENERATED BY AENEAS *)
(** [no_nested_borrows] *)
module NoNestedBorrows
open Primitives

#set-options "--z3rlimit 50 --fuel 1 --ifuel 1"

(** [no_nested_borrows::Pair]
    Source: 'src/no_nested_borrows.rs', lines 4:0-4:23 *)
type pair_t (t1 t2 : Type0) = { x : t1; y : t2; }

(** [no_nested_borrows::List]
    Source: 'src/no_nested_borrows.rs', lines 9:0-9:16 *)
type list_t (t : Type0) =
| List_Cons : t -> list_t t -> list_t t
| List_Nil : list_t t

(** [no_nested_borrows::One]
    Source: 'src/no_nested_borrows.rs', lines 20:0-20:16 *)
type one_t (t1 : Type0) = | One_One : t1 -> one_t t1

(** [no_nested_borrows::EmptyEnum]
    Source: 'src/no_nested_borrows.rs', lines 26:0-26:18 *)
type emptyEnum_t = | EmptyEnum_Empty : emptyEnum_t

(** [no_nested_borrows::Enum]
    Source: 'src/no_nested_borrows.rs', lines 32:0-32:13 *)
type enum_t = | Enum_Variant1 : enum_t | Enum_Variant2 : enum_t

(** [no_nested_borrows::EmptyStruct]
    Source: 'src/no_nested_borrows.rs', lines 39:0-39:22 *)
type emptyStruct_t = unit

(** [no_nested_borrows::Sum]
    Source: 'src/no_nested_borrows.rs', lines 41:0-41:20 *)
type sum_t (t1 t2 : Type0) =
| Sum_Left : t1 -> sum_t t1 t2
| Sum_Right : t2 -> sum_t t1 t2

(** [no_nested_borrows::neg_test]: forward function
    Source: 'src/no_nested_borrows.rs', lines 48:0-48:30 *)
let neg_test (x : i32) : result i32 =
  i32_neg x

(** [no_nested_borrows::add_u32]: forward function
    Source: 'src/no_nested_borrows.rs', lines 54:0-54:37 *)
let add_u32 (x : u32) (y : u32) : result u32 =
  u32_add x y

(** [no_nested_borrows::subs_u32]: forward function
    Source: 'src/no_nested_borrows.rs', lines 60:0-60:38 *)
let subs_u32 (x : u32) (y : u32) : result u32 =
  u32_sub x y

(** [no_nested_borrows::div_u32]: forward function
    Source: 'src/no_nested_borrows.rs', lines 66:0-66:37 *)
let div_u32 (x : u32) (y : u32) : result u32 =
  u32_div x y

(** [no_nested_borrows::div_u32_const]: forward function
    Source: 'src/no_nested_borrows.rs', lines 73:0-73:35 *)
let div_u32_const (x : u32) : result u32 =
  u32_div x 2

(** [no_nested_borrows::rem_u32]: forward function
    Source: 'src/no_nested_borrows.rs', lines 78:0-78:37 *)
let rem_u32 (x : u32) (y : u32) : result u32 =
  u32_rem x y

(** [no_nested_borrows::mul_u32]: forward function
    Source: 'src/no_nested_borrows.rs', lines 82:0-82:37 *)
let mul_u32 (x : u32) (y : u32) : result u32 =
  u32_mul x y

(** [no_nested_borrows::add_i32]: forward function
    Source: 'src/no_nested_borrows.rs', lines 88:0-88:37 *)
let add_i32 (x : i32) (y : i32) : result i32 =
  i32_add x y

(** [no_nested_borrows::subs_i32]: forward function
    Source: 'src/no_nested_borrows.rs', lines 92:0-92:38 *)
let subs_i32 (x : i32) (y : i32) : result i32 =
  i32_sub x y

(** [no_nested_borrows::div_i32]: forward function
    Source: 'src/no_nested_borrows.rs', lines 96:0-96:37 *)
let div_i32 (x : i32) (y : i32) : result i32 =
  i32_div x y

(** [no_nested_borrows::div_i32_const]: forward function
    Source: 'src/no_nested_borrows.rs', lines 100:0-100:35 *)
let div_i32_const (x : i32) : result i32 =
  i32_div x 2

(** [no_nested_borrows::rem_i32]: forward function
    Source: 'src/no_nested_borrows.rs', lines 104:0-104:37 *)
let rem_i32 (x : i32) (y : i32) : result i32 =
  i32_rem x y

(** [no_nested_borrows::mul_i32]: forward function
    Source: 'src/no_nested_borrows.rs', lines 108:0-108:37 *)
let mul_i32 (x : i32) (y : i32) : result i32 =
  i32_mul x y

(** [no_nested_borrows::mix_arith_u32]: forward function
    Source: 'src/no_nested_borrows.rs', lines 112:0-112:51 *)
let mix_arith_u32 (x : u32) (y : u32) (z : u32) : result u32 =
  let* i = u32_add x y in
  let* i1 = u32_div x y in
  let* i2 = u32_mul i i1 in
  let* i3 = u32_rem z y in
  let* i4 = u32_sub x i3 in
  let* i5 = u32_add i2 i4 in
  let* i6 = u32_add x y in
  let* i7 = u32_add i6 z in
  u32_rem i5 i7

(** [no_nested_borrows::mix_arith_i32]: forward function
    Source: 'src/no_nested_borrows.rs', lines 116:0-116:51 *)
let mix_arith_i32 (x : i32) (y : i32) (z : i32) : result i32 =
  let* i = i32_add x y in
  let* i1 = i32_div x y in
  let* i2 = i32_mul i i1 in
  let* i3 = i32_rem z y in
  let* i4 = i32_sub x i3 in
  let* i5 = i32_add i2 i4 in
  let* i6 = i32_add x y in
  let* i7 = i32_add i6 z in
  i32_rem i5 i7

(** [no_nested_borrows::CONST0]
    Source: 'src/no_nested_borrows.rs', lines 125:0-125:23 *)
let const0_body : result usize = usize_add 1 1
let const0_c : usize = eval_global const0_body

(** [no_nested_borrows::CONST1]
    Source: 'src/no_nested_borrows.rs', lines 126:0-126:23 *)
let const1_body : result usize = usize_mul 2 2
let const1_c : usize = eval_global const1_body

(** [no_nested_borrows::cast_u32_to_i32]: forward function
    Source: 'src/no_nested_borrows.rs', lines 128:0-128:37 *)
let cast_u32_to_i32 (x : u32) : result i32 =
  scalar_cast U32 I32 x

(** [no_nested_borrows::cast_bool_to_i32]: forward function
    Source: 'src/no_nested_borrows.rs', lines 132:0-132:39 *)
let cast_bool_to_i32 (x : bool) : result i32 =
  scalar_cast_bool I32 x

(** [no_nested_borrows::cast_bool_to_bool]: forward function
    Source: 'src/no_nested_borrows.rs', lines 137:0-137:41 *)
let cast_bool_to_bool (x : bool) : result bool =
  Return x

(** [no_nested_borrows::test2]: forward function
    Source: 'src/no_nested_borrows.rs', lines 142:0-142:14 *)
let test2 : result unit =
  let* _ = u32_add 23 44 in Return ()

(** Unit test for [no_nested_borrows::test2] *)
let _ = assert_norm (test2 = Return ())

(** [no_nested_borrows::get_max]: forward function
    Source: 'src/no_nested_borrows.rs', lines 154:0-154:37 *)
let get_max (x : u32) (y : u32) : result u32 =
  if x >= y then Return x else Return y

(** [no_nested_borrows::test3]: forward function
    Source: 'src/no_nested_borrows.rs', lines 162:0-162:14 *)
let test3 : result unit =
  let* x = get_max 4 3 in
  let* y = get_max 10 11 in
  let* z = u32_add x y in
  if not (z = 15) then Fail Failure else Return ()

(** Unit test for [no_nested_borrows::test3] *)
let _ = assert_norm (test3 = Return ())

(** [no_nested_borrows::test_neg1]: forward function
    Source: 'src/no_nested_borrows.rs', lines 169:0-169:18 *)
let test_neg1 : result unit =
  let* y = i32_neg 3 in if not (y = -3) then Fail Failure else Return ()

(** Unit test for [no_nested_borrows::test_neg1] *)
let _ = assert_norm (test_neg1 = Return ())

(** [no_nested_borrows::refs_test1]: forward function
    Source: 'src/no_nested_borrows.rs', lines 176:0-176:19 *)
let refs_test1 : result unit =
  if not (1 = 1) then Fail Failure else Return ()

(** Unit test for [no_nested_borrows::refs_test1] *)
let _ = assert_norm (refs_test1 = Return ())

(** [no_nested_borrows::refs_test2]: forward function
    Source: 'src/no_nested_borrows.rs', lines 187:0-187:19 *)
let refs_test2 : result unit =
  if not (2 = 2)
  then Fail Failure
  else
    if not (0 = 0)
    then Fail Failure
    else
      if not (2 = 2)
      then Fail Failure
      else if not (2 = 2) then Fail Failure else Return ()

(** Unit test for [no_nested_borrows::refs_test2] *)
let _ = assert_norm (refs_test2 = Return ())

(** [no_nested_borrows::test_list1]: forward function
    Source: 'src/no_nested_borrows.rs', lines 203:0-203:19 *)
let test_list1 : result unit =
  Return ()

(** Unit test for [no_nested_borrows::test_list1] *)
let _ = assert_norm (test_list1 = Return ())

(** [no_nested_borrows::test_box1]: forward function
    Source: 'src/no_nested_borrows.rs', lines 208:0-208:18 *)
let test_box1 : result unit =
  let* b = alloc_boxed_Box_deref_mut_back i32 0 1 in
  let* x = alloc_boxed_Box_deref i32 b in
  if not (x = 1) then Fail Failure else Return ()

(** Unit test for [no_nested_borrows::test_box1] *)
let _ = assert_norm (test_box1 = Return ())

(** [no_nested_borrows::copy_int]: forward function
    Source: 'src/no_nested_borrows.rs', lines 218:0-218:30 *)
let copy_int (x : i32) : result i32 =
  Return x

(** [no_nested_borrows::test_unreachable]: forward function
    Source: 'src/no_nested_borrows.rs', lines 224:0-224:32 *)
let test_unreachable (b : bool) : result unit =
  if b then Fail Failure else Return ()

(** [no_nested_borrows::test_panic]: forward function
    Source: 'src/no_nested_borrows.rs', lines 232:0-232:26 *)
let test_panic (b : bool) : result unit =
  if b then Fail Failure else Return ()

(** [no_nested_borrows::test_copy_int]: forward function
    Source: 'src/no_nested_borrows.rs', lines 239:0-239:22 *)
let test_copy_int : result unit =
  let* y = copy_int 0 in if not (0 = y) then Fail Failure else Return ()

(** Unit test for [no_nested_borrows::test_copy_int] *)
let _ = assert_norm (test_copy_int = Return ())

(** [no_nested_borrows::is_cons]: forward function
    Source: 'src/no_nested_borrows.rs', lines 246:0-246:38 *)
let is_cons (t : Type0) (l : list_t t) : result bool =
  begin match l with
  | List_Cons _ _ -> Return true
  | List_Nil -> Return false
  end

(** [no_nested_borrows::test_is_cons]: forward function
    Source: 'src/no_nested_borrows.rs', lines 253:0-253:21 *)
let test_is_cons : result unit =
  let* b = is_cons i32 (List_Cons 0 List_Nil) in
  if not b then Fail Failure else Return ()

(** Unit test for [no_nested_borrows::test_is_cons] *)
let _ = assert_norm (test_is_cons = Return ())

(** [no_nested_borrows::split_list]: forward function
    Source: 'src/no_nested_borrows.rs', lines 259:0-259:48 *)
let split_list (t : Type0) (l : list_t t) : result (t & (list_t t)) =
  begin match l with
  | List_Cons hd tl -> Return (hd, tl)
  | List_Nil -> Fail Failure
  end

(** [no_nested_borrows::test_split_list]: forward function
    Source: 'src/no_nested_borrows.rs', lines 267:0-267:24 *)
let test_split_list : result unit =
  let* p = split_list i32 (List_Cons 0 List_Nil) in
  let (hd, _) = p in
  if not (hd = 0) then Fail Failure else Return ()

(** Unit test for [no_nested_borrows::test_split_list] *)
let _ = assert_norm (test_split_list = Return ())

(** [no_nested_borrows::choose]: forward function
    Source: 'src/no_nested_borrows.rs', lines 274:0-274:70 *)
let choose (t : Type0) (b : bool) (x : t) (y : t) : result t =
  if b then Return x else Return y

(** [no_nested_borrows::choose]: backward function 0
    Source: 'src/no_nested_borrows.rs', lines 274:0-274:70 *)
let choose_back
  (t : Type0) (b : bool) (x : t) (y : t) (ret : t) : result (t & t) =
  if b then Return (ret, y) else Return (x, ret)

(** [no_nested_borrows::choose_test]: forward function
    Source: 'src/no_nested_borrows.rs', lines 282:0-282:20 *)
let choose_test : result unit =
  let* z = choose i32 true 0 0 in
  let* z1 = i32_add z 1 in
  if not (z1 = 1)
  then Fail Failure
  else
    let* (x, y) = choose_back i32 true 0 0 z1 in
    if not (x = 1)
    then Fail Failure
    else if not (y = 0) then Fail Failure else Return ()

(** Unit test for [no_nested_borrows::choose_test] *)
let _ = assert_norm (choose_test = Return ())

(** [no_nested_borrows::test_char]: forward function
    Source: 'src/no_nested_borrows.rs', lines 294:0-294:26 *)
let test_char : result char =
  Return 'a'

(** [no_nested_borrows::Tree]
    Source: 'src/no_nested_borrows.rs', lines 299:0-299:16 *)
type tree_t (t : Type0) =
| Tree_Leaf : t -> tree_t t
| Tree_Node : t -> nodeElem_t t -> tree_t t -> tree_t t

(** [no_nested_borrows::NodeElem]
    Source: 'src/no_nested_borrows.rs', lines 304:0-304:20 *)
and nodeElem_t (t : Type0) =
| NodeElem_Cons : tree_t t -> nodeElem_t t -> nodeElem_t t
| NodeElem_Nil : nodeElem_t t

(** [no_nested_borrows::list_length]: forward function
    Source: 'src/no_nested_borrows.rs', lines 339:0-339:48 *)
let rec list_length (t : Type0) (l : list_t t) : result u32 =
  begin match l with
  | List_Cons _ l1 -> let* i = list_length t l1 in u32_add 1 i
  | List_Nil -> Return 0
  end

(** [no_nested_borrows::list_nth_shared]: forward function
    Source: 'src/no_nested_borrows.rs', lines 347:0-347:62 *)
let rec list_nth_shared (t : Type0) (l : list_t t) (i : u32) : result t =
  begin match l with
  | List_Cons x tl ->
    if i = 0
    then Return x
    else let* i1 = u32_sub i 1 in list_nth_shared t tl i1
  | List_Nil -> Fail Failure
  end

(** [no_nested_borrows::list_nth_mut]: forward function
    Source: 'src/no_nested_borrows.rs', lines 363:0-363:67 *)
let rec list_nth_mut (t : Type0) (l : list_t t) (i : u32) : result t =
  begin match l with
  | List_Cons x tl ->
    if i = 0 then Return x else let* i1 = u32_sub i 1 in list_nth_mut t tl i1
  | List_Nil -> Fail Failure
  end

(** [no_nested_borrows::list_nth_mut]: backward function 0
    Source: 'src/no_nested_borrows.rs', lines 363:0-363:67 *)
let rec list_nth_mut_back
  (t : Type0) (l : list_t t) (i : u32) (ret : t) : result (list_t t) =
  begin match l with
  | List_Cons x tl ->
    if i = 0
    then Return (List_Cons ret tl)
    else
      let* i1 = u32_sub i 1 in
      let* tl1 = list_nth_mut_back t tl i1 ret in
      Return (List_Cons x tl1)
  | List_Nil -> Fail Failure
  end

(** [no_nested_borrows::list_rev_aux]: forward function
    Source: 'src/no_nested_borrows.rs', lines 379:0-379:63 *)
let rec list_rev_aux
  (t : Type0) (li : list_t t) (lo : list_t t) : result (list_t t) =
  begin match li with
  | List_Cons hd tl -> list_rev_aux t tl (List_Cons hd lo)
  | List_Nil -> Return lo
  end

(** [no_nested_borrows::list_rev]: merged forward/backward function
    (there is a single backward function, and the forward function returns ())
    Source: 'src/no_nested_borrows.rs', lines 393:0-393:42 *)
let list_rev (t : Type0) (l : list_t t) : result (list_t t) =
  let li = core_mem_replace (list_t t) l List_Nil in list_rev_aux t li List_Nil

(** [no_nested_borrows::test_list_functions]: forward function
    Source: 'src/no_nested_borrows.rs', lines 398:0-398:28 *)
let test_list_functions : result unit =
  let l = List_Cons 2 List_Nil in
  let l1 = List_Cons 1 l in
  let* i = list_length i32 (List_Cons 0 l1) in
  if not (i = 3)
  then Fail Failure
  else
    let* i1 = list_nth_shared i32 (List_Cons 0 l1) 0 in
    if not (i1 = 0)
    then Fail Failure
    else
      let* i2 = list_nth_shared i32 (List_Cons 0 l1) 1 in
      if not (i2 = 1)
      then Fail Failure
      else
        let* i3 = list_nth_shared i32 (List_Cons 0 l1) 2 in
        if not (i3 = 2)
        then Fail Failure
        else
          let* ls = list_nth_mut_back i32 (List_Cons 0 l1) 1 3 in
          let* i4 = list_nth_shared i32 ls 0 in
          if not (i4 = 0)
          then Fail Failure
          else
            let* i5 = list_nth_shared i32 ls 1 in
            if not (i5 = 3)
            then Fail Failure
            else
              let* i6 = list_nth_shared i32 ls 2 in
              if not (i6 = 2) then Fail Failure else Return ()

(** Unit test for [no_nested_borrows::test_list_functions] *)
let _ = assert_norm (test_list_functions = Return ())

(** [no_nested_borrows::id_mut_pair1]: forward function
    Source: 'src/no_nested_borrows.rs', lines 414:0-414:89 *)
let id_mut_pair1 (t1 t2 : Type0) (x : t1) (y : t2) : result (t1 & t2) =
  Return (x, y)

(** [no_nested_borrows::id_mut_pair1]: backward function 0
    Source: 'src/no_nested_borrows.rs', lines 414:0-414:89 *)
let id_mut_pair1_back
  (t1 t2 : Type0) (x : t1) (y : t2) (ret : (t1 & t2)) : result (t1 & t2) =
  let (x1, x2) = ret in Return (x1, x2)

(** [no_nested_borrows::id_mut_pair2]: forward function
    Source: 'src/no_nested_borrows.rs', lines 418:0-418:88 *)
let id_mut_pair2 (t1 t2 : Type0) (p : (t1 & t2)) : result (t1 & t2) =
  let (x, x1) = p in Return (x, x1)

(** [no_nested_borrows::id_mut_pair2]: backward function 0
    Source: 'src/no_nested_borrows.rs', lines 418:0-418:88 *)
let id_mut_pair2_back
  (t1 t2 : Type0) (p : (t1 & t2)) (ret : (t1 & t2)) : result (t1 & t2) =
  let (x, x1) = ret in Return (x, x1)

(** [no_nested_borrows::id_mut_pair3]: forward function
    Source: 'src/no_nested_borrows.rs', lines 422:0-422:93 *)
let id_mut_pair3 (t1 t2 : Type0) (x : t1) (y : t2) : result (t1 & t2) =
  Return (x, y)

(** [no_nested_borrows::id_mut_pair3]: backward function 0
    Source: 'src/no_nested_borrows.rs', lines 422:0-422:93 *)
let id_mut_pair3_back'a
  (t1 t2 : Type0) (x : t1) (y : t2) (ret : t1) : result t1 =
  Return ret

(** [no_nested_borrows::id_mut_pair3]: backward function 1
    Source: 'src/no_nested_borrows.rs', lines 422:0-422:93 *)
let id_mut_pair3_back'b
  (t1 t2 : Type0) (x : t1) (y : t2) (ret : t2) : result t2 =
  Return ret

(** [no_nested_borrows::id_mut_pair4]: forward function
    Source: 'src/no_nested_borrows.rs', lines 426:0-426:92 *)
let id_mut_pair4 (t1 t2 : Type0) (p : (t1 & t2)) : result (t1 & t2) =
  let (x, x1) = p in Return (x, x1)

(** [no_nested_borrows::id_mut_pair4]: backward function 0
    Source: 'src/no_nested_borrows.rs', lines 426:0-426:92 *)
let id_mut_pair4_back'a
  (t1 t2 : Type0) (p : (t1 & t2)) (ret : t1) : result t1 =
  Return ret

(** [no_nested_borrows::id_mut_pair4]: backward function 1
    Source: 'src/no_nested_borrows.rs', lines 426:0-426:92 *)
let id_mut_pair4_back'b
  (t1 t2 : Type0) (p : (t1 & t2)) (ret : t2) : result t2 =
  Return ret

(** [no_nested_borrows::StructWithTuple]
    Source: 'src/no_nested_borrows.rs', lines 433:0-433:34 *)
type structWithTuple_t (t1 t2 : Type0) = { p : (t1 & t2); }

(** [no_nested_borrows::new_tuple1]: forward function
    Source: 'src/no_nested_borrows.rs', lines 437:0-437:48 *)
let new_tuple1 : result (structWithTuple_t u32 u32) =
  Return { p = (1, 2) }

(** [no_nested_borrows::new_tuple2]: forward function
    Source: 'src/no_nested_borrows.rs', lines 441:0-441:48 *)
let new_tuple2 : result (structWithTuple_t i16 i16) =
  Return { p = (1, 2) }

(** [no_nested_borrows::new_tuple3]: forward function
    Source: 'src/no_nested_borrows.rs', lines 445:0-445:48 *)
let new_tuple3 : result (structWithTuple_t u64 i64) =
  Return { p = (1, 2) }

(** [no_nested_borrows::StructWithPair]
    Source: 'src/no_nested_borrows.rs', lines 450:0-450:33 *)
type structWithPair_t (t1 t2 : Type0) = { p : pair_t t1 t2; }

(** [no_nested_borrows::new_pair1]: forward function
    Source: 'src/no_nested_borrows.rs', lines 454:0-454:46 *)
let new_pair1 : result (structWithPair_t u32 u32) =
  Return { p = { x = 1; y = 2 } }

(** [no_nested_borrows::test_constants]: forward function
    Source: 'src/no_nested_borrows.rs', lines 462:0-462:23 *)
let test_constants : result unit =
  let* swt = new_tuple1 in
  let (i, _) = swt.p in
  if not (i = 1)
  then Fail Failure
  else
    let* swt1 = new_tuple2 in
    let (i1, _) = swt1.p in
    if not (i1 = 1)
    then Fail Failure
    else
      let* swt2 = new_tuple3 in
      let (i2, _) = swt2.p in
      if not (i2 = 1)
      then Fail Failure
      else
        let* swp = new_pair1 in
        if not (swp.p.x = 1) then Fail Failure else Return ()

(** Unit test for [no_nested_borrows::test_constants] *)
let _ = assert_norm (test_constants = Return ())

(** [no_nested_borrows::test_weird_borrows1]: forward function
    Source: 'src/no_nested_borrows.rs', lines 471:0-471:28 *)
let test_weird_borrows1 : result unit =
  Return ()

(** Unit test for [no_nested_borrows::test_weird_borrows1] *)
let _ = assert_norm (test_weird_borrows1 = Return ())

(** [no_nested_borrows::test_mem_replace]: merged forward/backward function
    (there is a single backward function, and the forward function returns ())
    Source: 'src/no_nested_borrows.rs', lines 481:0-481:37 *)
let test_mem_replace (px : u32) : result u32 =
  let y = core_mem_replace u32 px 1 in
  if not (y = 0) then Fail Failure else Return 2

(** [no_nested_borrows::test_shared_borrow_bool1]: forward function
    Source: 'src/no_nested_borrows.rs', lines 488:0-488:47 *)
let test_shared_borrow_bool1 (b : bool) : result u32 =
  if b then Return 0 else Return 1

(** [no_nested_borrows::test_shared_borrow_bool2]: forward function
    Source: 'src/no_nested_borrows.rs', lines 501:0-501:40 *)
let test_shared_borrow_bool2 : result u32 =
  Return 0

(** [no_nested_borrows::test_shared_borrow_enum1]: forward function
    Source: 'src/no_nested_borrows.rs', lines 516:0-516:52 *)
let test_shared_borrow_enum1 (l : list_t u32) : result u32 =
  begin match l with | List_Cons _ _ -> Return 1 | List_Nil -> Return 0 end

(** [no_nested_borrows::test_shared_borrow_enum2]: forward function
    Source: 'src/no_nested_borrows.rs', lines 528:0-528:40 *)
let test_shared_borrow_enum2 : result u32 =
  Return 0

(** [no_nested_borrows::incr]: merged forward/backward function
    (there is a single backward function, and the forward function returns ())
    Source: 'src/no_nested_borrows.rs', lines 539:0-539:24 *)
let incr (x : u32) : result u32 =
  u32_add x 1

(** [no_nested_borrows::call_incr]: forward function
    Source: 'src/no_nested_borrows.rs', lines 543:0-543:35 *)
let call_incr (x : u32) : result u32 =
  incr x

(** [no_nested_borrows::read_then_incr]: forward function
    Source: 'src/no_nested_borrows.rs', lines 548:0-548:41 *)
let read_then_incr (x : u32) : result u32 =
  let* _ = u32_add x 1 in Return x

(** [no_nested_borrows::read_then_incr]: backward function 0
    Source: 'src/no_nested_borrows.rs', lines 548:0-548:41 *)
let read_then_incr_back (x : u32) : result u32 =
  u32_add x 1

(** [no_nested_borrows::Tuple]
    Source: 'src/no_nested_borrows.rs', lines 554:0-554:24 *)
type tuple_t (t1 t2 : Type0) = t1 * t2

(** [no_nested_borrows::use_tuple_struct]: merged forward/backward function
    (there is a single backward function, and the forward function returns ())
    Source: 'src/no_nested_borrows.rs', lines 556:0-556:48 *)
let use_tuple_struct (x : tuple_t u32 u32) : result (tuple_t u32 u32) =
  let (_, i) = x in Return (1, i)

(** [no_nested_borrows::create_tuple_struct]: forward function
    Source: 'src/no_nested_borrows.rs', lines 560:0-560:61 *)
let create_tuple_struct (x : u32) (y : u64) : result (tuple_t u32 u64) =
  Return (x, y)

(** [no_nested_borrows::IdType]
    Source: 'src/no_nested_borrows.rs', lines 565:0-565:20 *)
type idType_t (t : Type0) = t

(** [no_nested_borrows::use_id_type]: forward function
    Source: 'src/no_nested_borrows.rs', lines 567:0-567:40 *)
let use_id_type (t : Type0) (x : idType_t t) : result t =
  Return x

(** [no_nested_borrows::create_id_type]: forward function
    Source: 'src/no_nested_borrows.rs', lines 571:0-571:43 *)
let create_id_type (t : Type0) (x : t) : result (idType_t t) =
  Return x

