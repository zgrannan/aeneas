(** [external]: external types.
-- This is a template file: rename it to "TypesExternal.lean" and fill the holes. *)
Require Import Primitives.
Import Primitives.
Require Import Coq.ZArith.ZArith.
Require Import List.
Import ListNotations.
Local Open Scope Primitives_scope.
Module External_TypesExternal.

(** [core::num::nonzero::NonZeroU32]
    Source: '/rustc/d59363ad0b6391b7fc5bbb02c9ccf9300eef3753/library/core/src/num/nonzero.rs', lines 50:12-50:33 *)
Axiom core_num_nonzero_NonZeroU32_t : Type.

(** The state type used in the state-error monad *)
Axiom state : Type.

End External_TypesExternal.
