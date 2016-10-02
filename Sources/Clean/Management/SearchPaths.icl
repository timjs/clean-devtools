implementation module Clean.Management.SearchPaths

from System.FilePath import
    :: FilePath
    
from syntax import
    :: SearchPaths{..}

makeSearchPaths :: [FilePath] -> SearchPaths
makeSearchPaths filepaths =
	{ sp_locations = []
	, sp_paths = filepaths
	}
