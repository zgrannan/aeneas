(** [hashmap_main]: external function declarations *)
Require Import Primitives.
Import Primitives.
Require Import Coq.ZArith.ZArith.
Require Import List.
Import ListNotations.
Local Open Scope Primitives_scope.
Require Export HashmapMain_Types.
Import HashmapMain_Types.
Module HashmapMain_FunsExternal.

(** [hashmap_main::hashmap_utils::deserialize]: forward function
    Source: 'src/hashmap_utils.rs', lines 10:0-10:43 *)
Axiom hashmap_utils_deserialize
  : state -> result (state * (hashmap_HashMap_t u64))
.

(** [hashmap_main::hashmap_utils::serialize]: forward function
    Source: 'src/hashmap_utils.rs', lines 5:0-5:42 *)
Axiom hashmap_utils_serialize
  : hashmap_HashMap_t u64 -> state -> result (state * unit)
.

End HashmapMain_FunsExternal.
