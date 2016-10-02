definition module Clean.Utilities.Optional

from Data.Maybe import :: Maybe(..)

from general import :: Optional(..)

isYes optional :==
    case optional of
        Yes _ -> True
        No -> False

isNo optional :==
    case optional of
        No -> True
        Yes _ -> False

// toMaybe :: !(Optional a) -> Maybe a
toMaybe optional :==
    case optional of
        Yes value -> Just value
        No -> Nothing
