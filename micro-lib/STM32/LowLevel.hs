module STM32.LowLevel(
  uPutChar, uPutStr, uPutStrLn,
  exit,
  IO, Int, String, Char,
  ) where
import qualified Prelude()
import Primitives
import Data.Char_Type
import Data.List_Type

foreign import ccall "uart.h lpuart1_write" write :: Int -> IO ()
foreign import ccall "extra.h myexit" myexit :: Int -> IO ()

uPutStrLn :: String -> IO ()
uPutStrLn s = uPutStr s `primThen` uPutChar '\r' `primThen` uPutChar '\n'

uPutStr :: String -> IO ()
uPutStr [] = primReturn ()
uPutStr (c:cs) = uPutChar c `primThen` uPutStr cs

uPutChar :: Char -> IO ()
uPutChar c = write (primOrd c)

exit :: Int -> a
exit rc = primUnsafeCoerce (primPerformIO (myexit rc))
