implementation module Clean.Management.Cache
/// - Note: designed to be imported qualified

from Heap import
    :: Heap
    , newHeap
from hashtable import
    :: HashTable
from syntax import
    :: SymbolTable
    , :: SymbolTableEntry
from predef import
    init_identifiers
from compile import
    :: DclCache
    , empty_cache

/*
makeHeap ::
    *Heap /// A fresh `Heap`.
*/
makeHeap :== newHeap

/*
initWithPredefinedIdentifiers ::
    !*SymbolTable /// The symbol table, represented as a `Heap`
    !*World /// The world
    ->
    ( !*SymbolTable /// The (modifed) symbol table
    , !*World /// The (modified) world
    )
/// Initializes a `SymbolTable` with predefined identifiers
*/
initWithPredefinedIdentifiers h w :== init_identifiers h w

/*
makeEmptyCacheOf ::
    !*SymbolTable /// The symbol table to initialize the cache with
    ->
    *DclCache /// The new cache for definition modules
*/
makeEmptyCacheOf h :== empty_cache h

makeDclCache :: !*World -> (*DclCache, *World)
makeDclCache world
    # (symbolTable, world) = initWithPredefinedIdentifiers makeHeap world
    # dclCache = makeEmptyCacheOf symbolTable
    = (dclCache, world)
