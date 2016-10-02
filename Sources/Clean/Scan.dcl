definition module Clean.Scan

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
