implementation module Clean.Scan

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

scanModule` a b c d e f g h i :==
    let (q, r, s, t, u, v, w, x, y, z) = scanModule a b c d e f g h i
    in ((q, r, s, t, u, v, w, x, y), z)

emptyCachedModuleIdents :== []

defaultModificationTimeFunction a b :== fmodificationtime a b

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
