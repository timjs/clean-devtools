implementation module Clean.Parse

import Data.Func
import Data.Maybe
import Data.Result
import System.File.Experimental

import System.FilePath

import Clean.Management.Cache
import Clean.Utilities.Optional
import Clean.Utilities.String

from StdFile import :: Files, class FileEnv(accFiles), instance FileEnv World, instance FileSystem Files
import StdClass
import StdArray, StdInt, StdChar

from Heap import :: Heap
from syntax import :: SymbolTable, :: SymbolTableEntry, :: Module, :: ParsedModule, :: ParsedDefinition, :: ScannedModule, :: CollectedDefinitions, :: ScannedInstanceAndMembersR, :: FunDef, :: IndexRange, :: ModTimeFunction,  :: Ident, :: Position(..), :: LineNr, :: FileName, :: FunctName, :: Type, :: DclModule
from hashtable import :: HashTable, :: IdentClass(..), :: BoxedIdent{..}, :: QualifiedIdents(..), putIdentInHashTable
from checksupport import :: Heaps
from predef import :: PredefinedSymbol, :: PredefinedSymbols
from parse import wantModule/* ::
    !*File /// The module file
    !{#Char} /// Modification time of module
    !Bool /// Is this an .icl module or not?
    !Ident /// Identifiers of module (?)
    !Position /// Position of ...
    !Bool /// Use generics?
    !*HashTable /// The hash table containing all identifiers
    !*File /// The error file
    !*Files /// The filesystem
	->
    ( !Bool /// Everything ok?
    , !Bool /// Used dynamic types?
    , !ParsedModule /// The result of the parsing
    , !*HashTable /// The (modified) hash table
    , !*File /// The (modified) module file
    , !*Files /// The (modified) filesystem
    )
    */
from predef import init_identifiers/* ::
    /// Initializes a `SymbolTalbe` with predefined identifiers
    !*SymbolTable /// The symbol table
    !*World /// The world
    ->
    ( !*SymbolTable /// The (modifed) symbol table
    , !*World /// The (modified) world
    )
    */

/// # Instances

instance toString ParseError where
    toString _ = "Compiler parser error"

instance toString CleanFileTypeError where
    toString (CleanFileTypeError wrongExtension) = "Expected a .dcl or .icl file but got: " +++ wrongExtension
    
/// # Macros

wantModule` a b c d e f g h i :==
    let (u, v, w, x, y, z) = wantModule a b c d e f g h i
    in ((u, v, w, x, y), z)

/// # Parse

useGenerics :== True
useDynamics :== True
emptyModificationTime :== ""

parseModule :: !FilePath !*DclCache !*World -> (Usually ParsedModule, *DclCache, *World)
parseModule modulePath dclCache world

    # (result, world) = openFile modulePath ReadMode world
    | isErr result =
        (rethrow result, dclCache, world)
    # moduleFile = unwrap result

    # (moduleBasename, moduleExtension) = splitExtension modulePath
    | not (isCleanExtension moduleExtension) =
        (throw $ CleanFileTypeError moduleExtension, dclCache, world)

    # moduleName = toModuleName moduleBasename
    # (moduleId, hashTable) = putIdentInHashTable moduleName (IC_Module NoQualifiedIdents) dclCache.hash_table
    # dclCache = {dclCache & hash_table = hashTable}
    # ((ok, useDynamics, parsedModule, hashTable, moduleFile), world) = accFiles (wantModule` moduleFile emptyModificationTime (isIclExtension moduleExtension) moduleId.boxed_ident NoPos useGenerics dclCache.hash_table stderr) world
    # dclCache = {dclCache & hash_table = hashTable}
    | not ok =
        (throw ParseError, dclCache, world)

    # (result, world) = closeFile moduleFile world
    | isErr result =
        (rethrow result, dclCache, world)
    | otherwise =
        (return parsedModule, dclCache, world)

/*
parseModule :: SearchPaths !FilePath !*DclCache !*World -> (Usually (ScannedModule, Maybe ScannedModule, [ScannedModule]), *DclCache, *World)
parseModule searchPaths modulePath dclCache world

    # (result, dclCache, world) = preparseModule modulePath dclCache world
    | isErr result
        = (rethrow result, dclCache, world)
    | otherwise
        = postparseModule (unwrap result) searchPaths dclCache world
*/
