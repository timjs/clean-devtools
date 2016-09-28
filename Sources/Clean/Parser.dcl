definition module Clean.Parser

from Data.Maybe import :: Maybe
from Data.Result import :: Result, :: Usually, :: Error
from System.FilePath import :: FilePath

from Heap import :: Heap
from syntax import :: SymbolTable, :: SymbolTableEntry, :: Module, :: ParsedModule, :: ParsedDefinition, :: ScannedModule, :: CollectedDefinitions, :: ScannedInstanceAndMembersR, :: FunDef, :: IndexRange, :: ModTimeFunction, :: SearchPaths, :: Ident, :: Position(..), :: LineNr, :: FileName, :: FunctName, :: Type, :: DclModule
// from predef import :: PredefinedSymbol, :: PredefinedSymbols
// from utilities import :: Optional

from compile import :: DclCache

:: Error
    | FileTypeError
    | PreparseError
    | PostparseError

initDclCache :: !*World -> *(*DclCache, *World)
makeSearchPaths :: [FilePath] -> SearchPaths

preparseModule :: !FilePath !*DclCache !*World -> (Usually ParsedModule, *DclCache, *World)
postparseModule :: ParsedModule SearchPaths !*DclCache !*World -> (Usually (ScannedModule, Maybe ScannedModule, [ScannedModule]), *DclCache, *World)

parseModule :: !FilePath SearchPaths !*DclCache !*World -> (Usually (ScannedModule, Maybe ScannedModule, [ScannedModule]), *DclCache, *World)
