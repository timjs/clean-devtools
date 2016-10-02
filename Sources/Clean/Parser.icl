implementation module Clean.Parser

import Data.Maybe
import Data.Result
import System.File.Experimental

import System.FilePath

from StdFile import :: Files, class FileEnv(accFiles), instance FileEnv World, instance FileSystem Files
import StdClass
import StdArray, StdInt, StdChar

from Heap import :: Heap, newHeap
from syntax import :: SymbolTable, :: SymbolTableEntry, :: Module, :: ParsedModule, :: ParsedDefinition, :: ScannedModule, :: CollectedDefinitions, :: ScannedInstanceAndMembersR, :: FunDef, :: IndexRange, :: ModTimeFunction, :: SearchPaths{..}, :: Ident, :: Position(..), :: LineNr, :: FileName, :: FunctName, :: Type, :: DclModule
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
from postparse import scanModule/* ::
    !ParsedModule /// Parsed module
    ![Ident] /// List of cached module identifiers
    !Bool /// Use generics?
    !Bool /// Use dynamics?
    !*HashTable /// The hash table containing all identifiers
    !*File /// The error file
    !SearchPaths /// Search paths
    (ModTimeFunction *Files) ///
    !*Files /// The filesystem
	->
    ( !Bool /// Everything ok?
    , !ScannedModule /// The result of the scanning
    , !IndexRange /// Range of global functions
    , ![FunDef] /// List of module function definitions
    , !Optional ScannedModule /// Optional scanned .dcl module
    , ![ScannedModule] /// List of .dcl modules needed by this module (?)
    , !Int /// Index of .dcl module in cache
    , !*HashTable /// The (modified) hash table
    , !*File /// The (modified) error file
    , !*Files /// The (modifed) filesystem
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
from compile import :: DclCache{..}, empty_cache/* ::
    !*SymbolTable /// The symbol table to initialize the cache with
    ->
    *DclCache /// The new cache with definitions
    */
from utilities import :: Optional(..)

from filesystem import fmodificationtime


/// # Macros


initWithPredefinedIdentifiers h w :== init_identifiers h w
makeEmptyCacheOf h :== empty_cache h
wantModule` a b c d e f g h i :==
    let (u, v, w, x, y, z) = wantModule a b c d e f g h i
    in ((u, v, w, x, y), z)
scanModule` a b c d e f g h i :==
    let (q, r, s, t, u, v, w, x, y, z) = scanModule a b c d e f g h i
    in ((q, r, s, t, u, v, w, x, y), z)
defaultModificationTimeFunction a b :== fmodificationtime a b

// isCleanFile :: !String -> Bool
isCleanFile extension :==
    case extension of
        "icl" -> True
        "dcl" -> True
        _ -> False

// isIclFile :: !String -> Bool
isIclFile extension :==
    case extension of
        "icl" -> True
        _ -> False

// isDclFile :: !String -> Bool
isDclFile extension :==
    case extension of
        "dcl" -> True
        _ -> False

// toModuleName, toFilePath :: !String -> String
toModuleName s :== { if (c == '/') '.' c \\ c <-: s }
toFilePath s :== { if (c == '.') '/' c \\ c <-: s }

// toMaybe :: !(Optional a) -> Maybe a
toMaybe optional :==
    case optional of
        Yes value -> Just value
        No -> Nothing


/// # Cache


initDclCache :: !*World -> *(*DclCache, *World)
initDclCache world
    # (symbolTable, world) = initWithPredefinedIdentifiers newHeap world
    # dclCache = makeEmptyCacheOf symbolTable
    = (dclCache, world)


/// # Search Paths


makeSearchPaths :: [FilePath] -> SearchPaths
makeSearchPaths filepaths =
	{ sp_locations = []
	, sp_paths = filepaths
	}


/// # Parse


useGenerics :== True
useDynamics :== True
emptyModificationTime :== ""
emptyCachedModuleIdents :== []


parseModule :: !FilePath !*DclCache !*World -> (Usually ParsedModule, *DclCache, *World)
parseModule modulePath dclCache world

    # (result, world) = openFile modulePath ReadMode world
    | isErr result =
        (rethrow result, dclCache, world)
    # moduleFile = unwrap result

    # (moduleBasename, moduleExtension) = splitExtension modulePath
    | not (isCleanFile moduleExtension) =
        (throw FileTypeError, dclCache, world)

    # moduleName = toModuleName moduleBasename
    # (moduleId, hashTable) = putIdentInHashTable moduleName (IC_Module NoQualifiedIdents) dclCache.hash_table
    # dclCache = {dclCache & hash_table = hashTable}
    # ((ok, useDynamics, parsedModule, hashTable, moduleFile), world) = accFiles (wantModule` moduleFile emptyModificationTime (isIclFile moduleExtension) moduleId.boxed_ident NoPos useGenerics dclCache.hash_table stderr) world
    # dclCache = {dclCache & hash_table = hashTable}
    | not ok =
        (throw ParseError, dclCache, world)

    # (result, world) = closeFile moduleFile world
    | isErr result =
        (rethrow result, dclCache, world)
    | otherwise =
        (return parsedModule, dclCache, world)


/*
scanModule :: [FilePath] !ParsedModule !*DclCache !*World -> (Usually (ScannedModule, Maybe ScannedModule, [ScannedModule]), *DclCache, *World)
scanModule filePaths parsedModule dclCache world

    # searchPaths = makeSearchPaths filePaths
    # ((ok, module, globalFunctionsRange, functionDefinitions, optionalDclModule, importedModules, dclCacheIndex, hashTable, _), world) = accFiles (scanModule` parsedModule emptyCachedModuleIdents useGenerics useDynamics dclCache.hash_table stderr searchPaths defaultModificationTimeFunction) world
    # dclCache = {dclCache & hash_table = hashTable}
    | not ok
        = (throw ScanError, dclCache, world)
    | otherwise
        = (return (module, toMaybe optionalDclModule, importedModules), dclCache, world)
*/

/*
parseModule :: SearchPaths !FilePath !*DclCache !*World -> (Usually (ScannedModule, Maybe ScannedModule, [ScannedModule]), *DclCache, *World)
parseModule searchPaths modulePath dclCache world

    # (result, dclCache, world) = preparseModule modulePath dclCache world
    | isErr result
        = (rethrow result, dclCache, world)
    | otherwise
        = postparseModule (unwrap result) searchPaths dclCache world
*/
