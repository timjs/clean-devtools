definition module Clean.Management.SearchPaths

from System.FilePath import
    :: FilePath

from syntax import
    :: SearchPaths

makeSearchPaths ::
    [FilePath] /// List of `FilePath`s to put into `SearchPaths`
    ->
    SearchPaths /// `SearchPaths` containing given `FilePath`s
/// Creates a new `SearchPaths` object out of the give `FilePath`s list.
