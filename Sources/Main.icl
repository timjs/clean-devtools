module Main

import Data.Func

import Data.List
import Data.Maybe
import Data.Result

import System.CommandLine
import Clean.Parse

searchPaths =
    [ "../Sources/"
    , "~/Dropbox/Projecten/clean-platform/src/libraries/OS-Independent/"
    , "~/Dropbox/Projecten/clean-platform/src/libraries/OS-Mac/"
    , "~/Dropbox/Projecten/clean-platform/src/libraries/OS-Posix/"
    , "~/Dropbox/Projecten/clean-compiler/frontend/"
    , "~/Dropbox/Projecten/clean-compiler/backend/"
    , "~/Dropbox/Projecten/clean-compiler/main/"
    , "~/Dropbox/Projecten/clean-compiler/main/Unix/"
    , "/Applications/Clean/lib/ArgEnv/"
    , "/Applications/Clean/lib/Generics/"
    , "/Applications/Clean/lib/Dynamics/"
    , "/Applications/Clean/lib/StdEnv/"
    ]

Start world
    # (args, world) = getCommandLine world
    # fileName = args !! 1
    # (dclCache, world) = makeDclCache world
    # (result, dclCache, world) = parseModule fileName dclCache world
    | isErr result
        = panic result
    | otherwise
        = unwrap result
    /*
    # (result, dclCache, world) = scanModule searchPaths parsedModule dclCache world
    | isErr result
        = panic result
    # (module, maybeDclModule, importedModules) = unwrap result
    # (Just dclModule) = maybeDclModule
    | otherwise
        = ( getModuleIdent module
        , getModuleIdent dclModule
        , map getModuleIdent importedModules
        , map (\td -> td.td_ident.id_name) module.mod_defs.def_types
        , map (\ft -> ft.ft_ident.id_name) module.mod_defs.def_funtypes
        , map (\td -> td.td_ident.id_name) dclModule.mod_defs.def_types
        , map (\ft -> ft.ft_ident.id_name) dclModule.mod_defs.def_funtypes
        )
    */
