module STMPrelude(
  module Mhs.Builtin,
  module Data.Eq,
  module Data.Function,
  Int,
  IO,
  Ptr,
  Num(..),
  module Data.List_Type, cycle,
  putChar, putStr, putStrLn,
  error,
  showInt,
  ) where
--import qualified Prelude()
import Control.Monad
import Data.Char(ord)
import Data.Char_Type
import Data.Eq
import Data.Function
import Data.Int
import Data.List_Type
import Data.Num
import Foreign.Ptr
import Mhs.Builtin
import System.IO(IO)
import System.IO.Unsafe

default Num (Int)

putStrLn :: String -> IO ()
putStrLn s = putStr s >> putChar '\r' >> putChar '\n'

putStr :: String -> IO ()
putStr = mapM_ putChar

putChar :: Char -> IO ()
putChar c = write (ord c)

foreign import ccall "uart.h lpuart1_write" write :: Int -> IO ()
foreign import ccall "extra.h myexit" exit :: Int -> IO ()

cycle :: [a] -> [a]
cycle [] = error "cycle"
cycle xs = let xs' = xs ++ xs' in xs'

error :: String -> a
error s = seq (unsafePerformIO (putStrLn s >> exit 1)) (boo ())
  where boo _ = boo ()

showInt :: Int -> String
showInt i =  if i < 10 then r else showInt (i `quot` 10) ++ r
  where r = [chr (i `rem` 10 + ord '0')]

chr :: Int -> Char
chr = _primitive "chr"

rem :: Int -> Int -> Int
rem = _primitive "rem"
quot :: Int -> Int -> Int
quot = _primitive "quot"
