definition module Clean.Parser

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

preparseModule :: !FilePath !*DclCache !*World -> (Usually ParsedModule, *DclCache, *World)
// postparseModule ::
// parseModule :: !FilePath !*DclCache !*World -> (Usually ScannedModule, *DclCache, *World)
