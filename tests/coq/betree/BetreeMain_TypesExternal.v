(** [betree_main]: external types.
-- This is a template file: rename it to "TypesExternal.lean" and fill the holes. *)
Require Import Primitives.
Import Primitives.
Require Import Coq.ZArith.ZArith.
Require Import List.
Import ListNotations.
Local Open Scope Primitives_scope.
Module BetreeMain_TypesExternal.

(** The state type used in the state-error monad *)
Axiom state : Type.

End BetreeMain_TypesExternal.
