module STMPrelude(
  module Mhs.Builtin,
  module Data.Eq,
  Int,
  IO,
  Ptr,
  module Data.List_Type, cycle,
  putChar, putStr, putStrLn,
  error,
  ) where
--import qualified Prelude()
import Control.Monad
import Data.Char(ord)
import Data.Char_Type
import Data.Eq
import Data.Int
import Data.List_Type
import Foreign.Ptr
import Mhs.Builtin
import System.IO(IO)
import System.IO.Unsafe

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
