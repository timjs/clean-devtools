definition module Clean.Management.Cache

from hashtable import
    :: HashTable
from compile import
    :: DclCache{hash_table}

makeDclCache ::
    !*World /// The world
    ->
    ( *DclCache /// A new definition module cache
    , *World /// The (modified) world
    )
/// Creates a new definition module cache out of the `World`.
///
/// The definition module cache is used by the compiler to speed up consecutive parsing of definition modules.
