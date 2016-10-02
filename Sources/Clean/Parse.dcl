definition module Clean.Parse

from Data.Maybe import :: Maybe
from Data.Result import :: Result, :: Usually, :: ErrorWitness
from Data.String import class toString

from System.FilePath import :: FilePath

import Clean.Management.Cache

import qualified syntax

:: ParseError = ParseError
instance toString ParseError

:: CleanFileTypeError = CleanFileTypeError WrongExtension
:: WrongExtension :== String
instance toString CleanFileTypeError

parseModule ::
    !FilePath /// Path of the module
    !*DclCache /// The definition module cache
    !*World /// The world
    ->
    ( Usually 'syntax'.ParsedModule /// Result of the parse or an error
    , *DclCache /// The (modified) definition module cache
    , *World /// The (modified) world
    )
/// Parses the given file and returns a `ParsedModule`.
