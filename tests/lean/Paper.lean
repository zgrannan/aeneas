-- THIS FILE WAS AUTOMATICALLY GENERATED BY AENEAS
-- [paper]
import Base
open Primitives

namespace paper

/- [paper::ref_incr]: merged forward/backward function
   (there is a single backward function, and the forward function returns ())
   Source: 'src/paper.rs', lines 4:0-4:28 -/
def ref_incr (x : I32) : Result I32 :=
  x + 1#i32

/- [paper::test_incr]: forward function
   Source: 'src/paper.rs', lines 8:0-8:18 -/
def test_incr : Result Unit :=
  do
    let x ← ref_incr 0#i32
    if not (x = 1#i32)
    then Result.fail Error.panic
    else Result.ret ()

/- Unit test for [paper::test_incr] -/
#assert (test_incr == .ret ())

/- [paper::choose]: forward function
   Source: 'src/paper.rs', lines 15:0-15:70 -/
def choose (T : Type) (b : Bool) (x : T) (y : T) : Result T :=
  if b
  then Result.ret x
  else Result.ret y

/- [paper::choose]: backward function 0
   Source: 'src/paper.rs', lines 15:0-15:70 -/
def choose_back
  (T : Type) (b : Bool) (x : T) (y : T) (ret0 : T) : Result (T × T) :=
  if b
  then Result.ret (ret0, y)
  else Result.ret (x, ret0)

/- [paper::test_choose]: forward function
   Source: 'src/paper.rs', lines 23:0-23:20 -/
def test_choose : Result Unit :=
  do
    let z ← choose I32 true 0#i32 0#i32
    let z0 ← z + 1#i32
    if not (z0 = 1#i32)
    then Result.fail Error.panic
    else
      do
        let (x, y) ← choose_back I32 true 0#i32 0#i32 z0
        if not (x = 1#i32)
        then Result.fail Error.panic
        else if not (y = 0#i32)
             then Result.fail Error.panic
             else Result.ret ()

/- Unit test for [paper::test_choose] -/
#assert (test_choose == .ret ())

/- [paper::List]
   Source: 'src/paper.rs', lines 35:0-35:16 -/
inductive List (T : Type) :=
| Cons : T → List T → List T
| Nil : List T

/- [paper::list_nth_mut]: forward function
   Source: 'src/paper.rs', lines 42:0-42:67 -/
divergent def list_nth_mut (T : Type) (l : List T) (i : U32) : Result T :=
  match l with
  | List.Cons x tl =>
    if i = 0#u32
    then Result.ret x
    else do
           let i0 ← i - 1#u32
           list_nth_mut T tl i0
  | List.Nil => Result.fail Error.panic

/- [paper::list_nth_mut]: backward function 0
   Source: 'src/paper.rs', lines 42:0-42:67 -/
divergent def list_nth_mut_back
  (T : Type) (l : List T) (i : U32) (ret0 : T) : Result (List T) :=
  match l with
  | List.Cons x tl =>
    if i = 0#u32
    then Result.ret (List.Cons ret0 tl)
    else
      do
        let i0 ← i - 1#u32
        let tl0 ← list_nth_mut_back T tl i0 ret0
        Result.ret (List.Cons x tl0)
  | List.Nil => Result.fail Error.panic

/- [paper::sum]: forward function
   Source: 'src/paper.rs', lines 57:0-57:32 -/
divergent def sum (l : List I32) : Result I32 :=
  match l with
  | List.Cons x tl => do
                        let i ← sum tl
                        x + i
  | List.Nil => Result.ret 0#i32

/- [paper::test_nth]: forward function
   Source: 'src/paper.rs', lines 68:0-68:17 -/
def test_nth : Result Unit :=
  do
    let l := List.Nil
    let l0 := List.Cons 3#i32 l
    let l1 := List.Cons 2#i32 l0
    let x ← list_nth_mut I32 (List.Cons 1#i32 l1) 2#u32
    let x0 ← x + 1#i32
    let l2 ← list_nth_mut_back I32 (List.Cons 1#i32 l1) 2#u32 x0
    let i ← sum l2
    if not (i = 7#i32)
    then Result.fail Error.panic
    else Result.ret ()

/- Unit test for [paper::test_nth] -/
#assert (test_nth == .ret ())

/- [paper::call_choose]: forward function
   Source: 'src/paper.rs', lines 76:0-76:44 -/
def call_choose (p : (U32 × U32)) : Result U32 :=
  do
    let (px, py) := p
    let pz ← choose U32 true px py
    let pz0 ← pz + 1#u32
    let (px0, _) ← choose_back U32 true px py pz0
    Result.ret px0

end paper