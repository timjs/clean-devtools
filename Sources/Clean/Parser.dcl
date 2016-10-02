definition module Clean.Parser

from Data.Maybe import :: Maybe
from Data.Result import :: Result, :: Usually, :: Error
from System.FilePath import :: FilePath

from Heap import :: Heap
from syntax import
    :: SymbolTable
    , :: SymbolTableEntry
    , :: Module{..}
    , :: ParsedModule
    , :: ParsedDefinition
    , :: ScannedModule
    , :: CollectedDefinitions{..}
    , :: ScannedInstanceAndMembersR
    , :: IndexRange
    , :: ModTimeFunction
    , :: SearchPaths
    , :: Ident{..}
    , :: Position(..)
    , :: LineNr
    , :: FileName
    , :: FunctName
    , :: Type
    , :: DclModule
    , :: ParsedForeignExport
    , :: ImportedObject
    , :: Import
    , :: ParsedImport
    , :: ModuleKind
    , :: SymbolPtr
    , :: Ptr
    , :: GenericCaseDef
    , :: GenericDef
    , :: FunType{..}
    , :: MemberDef
    , :: ClassDef
    , :: SelectorDef
    , :: ConsDef
    , :: TypeDef{..}
    , :: TypeRhs
    , :: FunDef
    , :: Index
    , :: GlobalIndex
    , :: TypeAttribute
    , :: AttributeVar
    , :: ATypeVar
    , :: VarInfo
    , :: VarInfoPtr
    , :: FunSpecials
    , :: SymbolType
    , :: Priority

// from predef import :: PredefinedSymbol, :: PredefinedSymbols
// from utilities import :: Optional

from compile import :: DclCache

:: Error
    | FileTypeError
    | ParseError
    | ScanError

initDclCache ::
    !*World /// The world
    ->
    *(*DclCache /// A new definition module cache
    , *World /// The (modified) world
    )
/// Creates a new definition module cache,
/// used by the compiler to speed up consecutive parsing of definition modules,
/// out of the `World`.

parseModule ::
    !FilePath /// Path of the module
    !*DclCache /// The definition module cache
    !*World /// The world
    ->
    ( Usually ParsedModule /// Result of the parse or an error
    , *DclCache /// The (modified) definition module cache
    , *World /// The (modified) world
    )
/// Parses the given file and returns a `ParsedModule`.

/*
scanModule ::
    [FilePath] /// List of directories to look for definition modules
    !ParsedModule /// Preparsed module
    !*DclCache /// The cache of definition modules used to speed up lookup and parsing
    !*World /// The world
    ->
    (Usually
        ( ScannedModule /// Scanned version of the module
        , Maybe ScannedModule /// Accompanied scanned definition module (not applicable if this was a main module)
        , [ScannedModule] /// Scanned imported definition modules
        )
    , *DclCache /// The (modified) definition cache
    , *World /// The (modified) world
    )
/// Scans an already parsed _implementation_ module, including it's definition module and its imports.
///
/// - Warning: it is not possible to scan a sole _definition_ module, so don't try it!
/// - Note: an accompanied definition module is only returned if this implementation module is _not_ a main module.
*/
