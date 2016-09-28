module Main

import Data.List
import System.CommandLine
import Clean.Parser

searchPaths = makeSearchPaths
    [ "../Sources/"
    , "../Dependencies/clean-platform/src/libraries/OS-Independent/"
    , "../Dependencies/clean-platform/src/libraries/OS-Mac/"
    , "../Dependencies/clean-platform/src/libraries/OS-Posix/"
    , "../Dependencies/clean-compiler/frontend/"
    , "../Dependencies/clean-compiler/backend/"
    , "../Dependencies/clean-compiler/main/"
    , "../Dependencies/clean-compiler/main/Unix/"
    , "/Applications/Clean/lib/Generics/"
    , "/Applications/Clean/lib/ArgEnv/"
    ]

Start world
    # (args, world) = getCommandLine world
    # fileName = args !! 1
    # (dclCache, world) = initDclCache world
    = preparseModule fileName dclCache world
