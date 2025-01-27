-- [hashmap_main]: opaque function definitions
import Base
import HashmapMain.Types
open Primitives

namespace hashmap_main

structure OpaqueDefs where
  
  /- [hashmap_main::hashmap_utils::deserialize] -/
  hashmap_utils.deserialize_fwd
    : State → Result (State × (hashmap_hash_map_t U64))
  
  /- [hashmap_main::hashmap_utils::serialize] -/
  hashmap_utils.serialize_fwd
    : hashmap_hash_map_t U64 → State → Result (State × Unit)
  
end hashmap_main
