
(* Copyright (C) 2017 Authors of BuckleScript
 * 
 * This program is free software: you can redistribute it and/or modify
 * it under the terms of the GNU Lesser General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or
 * (at your option) any later version.
 *
 * In addition to the permissions granted to you by the LGPL, you may combine
 * or link a "work that uses the Library" with a publicly distributed version
 * of this file to produce a combined library or application, then distribute
 * that combined work under the terms of your choosing, with no requirement
 * to comply with the obligations normally placed on you by section 4 of the
 * LGPL version 3 (or the corresponding section of a later version of the LGPL
 * should you choose to use a later version).
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU Lesser General Public License for more details.
 * 
 * You should have received a copy of the GNU Lesser General Public License
 * along with this program; if not, write to the Free Software
 * Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA 02111-1307, USA. *)

type ('k,'v,'id) t
type ('key, 'id) dict = ('key, 'id) Bs_Cmp.t
    
val empty: dict:('k, 'id) dict -> ('k, 'a, 'id) t 
val isEmpty: _ t -> bool
val has: ('k, _, _) t -> 'k  -> bool
val cmp: 
    ('k, 'a, 'id) t -> 
    ('k, 'a, 'id) t ->
    ('a -> 'a -> int [@bs]) -> 
     int
(** [cmp m1 m2 cmp]
    First compare by size, if size is the same,
    compare by key, value pair
*)     
val eq:  ('k, 'a, 'id) t -> ('k, 'a, 'id) t -> ('a -> 'a -> bool [@bs]) -> bool
(** [eq m1 m2 eqf] tests whether the maps [m1] and [m2] are
    equal, that is, contain equal keys and associate them with
    equal data.  [eqf] is the equality predicate used to compare
    the data associated with the keys. *)
    
val forEach:  ('k, 'a, 'id) t -> ('k -> 'a -> unit [@bs]) -> unit
(** [forEach m f] applies [f] to all bindings in map [m].
    [f] receives the 'k as first argument, and the associated value
    as second argument.  The bindings are passed to [f] in increasing
    order with respect to the ordering over the type of the keys. *)
    
val reduce: ('k, 'a, 'id) t -> 'b ->  ('b -> 'k -> 'a -> 'b [@bs]) ->  'b
(** [reduce m a f] computes [(f kN dN ... (f k1 d1 a)...)],
    where [k1 ... kN] are the keys of all bindings in [m]
    (in increasing order), and [d1 ... dN] are the associated data. *)

val every: ('k, 'a, 'id) t -> ('k -> 'a -> bool [@bs]) ->  bool
(** [every m p] checks if all the bindings of the map
    satisfy the predicate [p].
*)
    

val some: ('k, 'a, 'id) t -> ('k -> 'a -> bool [@bs]) ->  bool
(** [some m p] checks if at least one binding of the map
    satisfy the predicate [p].
*)
val size: ('k, 'a, 'id) t -> int


val toList: ('k, 'a, 'id) t -> ('k * 'a) list
(** In increasing order*)
val toArray: ('k, 'a, 'id) t -> ('k * 'a) array
val ofArray: ('k * 'a) array -> dict:('k,'id) dict ->  ('k,'a,'id) t    
val keysToArray: ('k, _, _) t -> 'k array 
val valuesToArray: (_, 'a, _) t -> 'a array
val minKey: ('k, _,  _) t -> 'k option
val minKeyUndefined: ('k, _,  _) t -> 'k Js.undefined
val maxKey: ('k, _,  _) t -> 'k option
val maxKeyUndefined: ('k, _,  _) t -> 'k Js.undefined
val minimum: ('k, 'a,  _) t -> ('k * 'a) option
val minUndefined: ('k, 'a, _) t -> ('k * 'a) Js.undefined
val maximum: ('k, 'a, _) t -> ('k * 'a) option
val maxUndefined:('k, 'a, _) t -> ('k * 'a) Js.undefined
val get:  ('k, 'a, 'id) t -> 'k -> 'a option
val getUndefined: ('k, 'a, 'id) t -> 'k ->  'a Js.undefined
val getWithDefault:
    ('k, 'a, 'id) t -> 'k ->  'a -> 'a 
val getExn:  ('k, 'a, 'id) t -> 'k ->  'a 
val checkInvariantInternal: _ t -> bool   
(****************************************************************************)

(*TODO: add functional [merge, partition, keepBy, split]*)

val remove:  ('k, 'a, 'id) t -> 'k -> unit
(** [remove m x] do the in-place modification,
*)
val removeMany: ('k, 'a, 'id) t -> 'k array -> unit    
  
val set: ('k, 'a, 'id) t -> 'k -> 'a ->  unit
(** [set m x y ] do the in-place modification *)
    
val update: ('k, 'a, 'id) t -> 'k -> ('a option -> 'a option [@bs]) -> unit

val mergeMany:  ('k, 'a, 'id) t -> ('k * 'a) array ->  unit

val map: ('k, 'a, 'id) t -> ('a -> 'b [@bs]) ->  ('k ,'b,'id ) t
(** [map m f] returns a map with same domain as [m], where the
    associated value [a] of all bindings of [m] has been
    replaced by the result of the application of [f] to [a].
    The bindings are passed to [f] in increasing order
    with respect to the ordering over the type of the keys. *)

val mapWithKey: ('k, 'a, 'id) t -> ('k -> 'a -> 'b [@bs]) -> ('k, 'b, 'id) t
    


