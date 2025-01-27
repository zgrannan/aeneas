(** [external]: external function declarations *)
Require Import Primitives.
Import Primitives.
Require Import Coq.ZArith.ZArith.
Require Import List.
Import ListNotations.
Local Open Scope Primitives_scope.
Require Export External_Types.
Include External_Types.
Module External_FunsExternal.

(** [core::mem::swap]:
    Source: '/rustc/d59363ad0b6391b7fc5bbb02c9ccf9300eef3753/library/core/src/mem/mod.rs', lines 726:0-726:42 *)
Definition core_mem_swap (T : Type) (x : T) (y : T) (s : state) :=
  Ok (s, (y, x))
.

(** [core::num::nonzero::{core::num::nonzero::NonZeroU32#14}::new]: forward function
    Source: '/rustc/d59363ad0b6391b7fc5bbb02c9ccf9300eef3753/library/core/src/num/nonzero.rs', lines 79:16-79:57 *)
Axiom core_num_nonzero_NonZeroU32_new
  : u32 -> state -> result (state * (option core_num_nonzero_NonZeroU32_t))
.

(** [core::option::{core::option::Option<T>}::unwrap]: forward function
    Source: '/rustc/d59363ad0b6391b7fc5bbb02c9ccf9300eef3753/library/core/src/option.rs', lines 932:4-932:34 *)
Axiom core_option_Option_unwrap :
  forall(T : Type), option T -> state -> result (state * T)
.

End External_FunsExternal.
