module Main

import Data.List
import System.CommandLine
import Clean.Parser

Start world
    # (args, world) = getCommandLine world
    # fileName = args !! 1
    # (dclCache, world) = initDclCache world
    = preparseModule fileName dclCache world
