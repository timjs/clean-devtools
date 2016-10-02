definition module Clean.Utilities.String

import StdClass, StdArray

from utilities import
    isSpecialChar
    , isUpperCaseName
    , isLowerCaseName
    , isFunnyIdName

// isCleanExtension :: !String -> Bool
isCleanExtension extension :==
    case extension of
        "icl" -> True
        "dcl" -> True
        _ -> False

// isIclExtension :: !String -> Bool
isIclExtension extension :==
    case extension of
        "icl" -> True
        _ -> False

// isDclExtension :: !String -> Bool
isDclExtension extension :==
    case extension of
        "dcl" -> True
        _ -> False

// toModuleName, toFilePath :: !String -> String
toModuleName s :== { if (c == '/') '.' c \\ c <-: s }
toFilePath s :== { if (c == '.') '/' c \\ c <-: s }
