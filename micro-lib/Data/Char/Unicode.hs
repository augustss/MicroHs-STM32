module Data.Char.Unicode (
        GeneralCategory (..), generalCategory,
        unicodeVersion,
        isControl,
        isPrint, isSpace, isUpper,
        isLower, isAlpha, isDigit,
        isAlphaNum, isNumber,
        isMark, isSeparator,
        isPunctuation, isSymbol,
        toTitle, toUpper, toLower,
    ) where
import qualified Prelude(); import MiniPrelude

uni :: a
uni = error "Unicode"

data GeneralCategory

unicodeVersion :: String
unicodeVersion = uni

isControl :: Char -> Bool
isControl = uni

isPrint :: Char -> Bool
isPrint = uni

isSpace :: Char -> Bool
isSpace = uni

isUpper :: Char -> Bool
isUpper = uni

isLower :: Char -> Bool
isLower = uni

isAlpha :: Char -> Bool
isAlpha = uni

isAlphaNum :: Char -> Bool
isAlphaNum = uni

isNumber :: Char -> Bool
isNumber = uni

isMark :: Char -> Bool
isMark = uni

isSeparator :: Char -> Bool
isSeparator = uni

isPunctuation :: Char -> Bool
isPunctuation = uni

isSymbol :: Char -> Bool
isSymbol = uni

toTitle :: Char -> Char
toTitle = uni

toUpper :: Char -> Char
toUpper = uni

toLower :: Char -> Char
toLower = uni

generalCategory :: Char -> GeneralCategory
generalCategory = uni
