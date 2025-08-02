module System.IO.Open(
  stdin, stdout, stderr,
  openFileM,
  openBinaryFileM,
  ) where
import qualified Prelude()              -- do not import Prelude
import Primitives(ForeignPtr, IO, Int, primPerformIO)
import Control.Monad
import Data.Char
import Data.Function
import Data.Functor
import Data.Maybe
import Foreign.C.String
import Foreign.Ptr
import Mhs.Builtin
import System.IO.Internal

-- Functions returning Handles
-- These can be based on FILE or file descriptors.

stdin  :: Handle
stdin  = std 0 ReadMode  "stdin"
stdout :: Handle
stdout = std 1 WriteMode "stdout"
stderr :: Handle
stderr = std 2 WriteMode "stderr"

std :: Int -> IOMode -> String -> Handle
std fd mode desc = primPerformIO $ openFD False fd desc mode

openFileM :: FilePath -> IOMode -> IO (Maybe Handle)
openFileM = openM False

openBinaryFileM :: String -> IOMode -> IO (Maybe Handle)
openBinaryFileM = openM True

openM :: Bool -> FilePath -> IOMode -> IO (Maybe Handle)
opemM raw name mode =
  openAsFd name mode >>= maybe (return Nothing) (\ fd -> Just <$> openFD raw fd name mode)

foreign import ccall "add_fd"   c_add_fd   :: Int -> IO (Ptr BFILE)
--foreign import ccall "add_buf" c_add_buf :: Ptr BFILE -> Int -> IO (Ptr BFILE)
foreign import ccall "open"     c_open     :: CString   -> Int -> Int -> IO Int
foreign import ccall "add_crlf" c_add_crlf :: Ptr BFILE -> IO (Ptr BFILE)

-- Buffering is pointless for the UART
openFD :: Bool -> Int -> String -> IOMode -> IO Handle
openFD raw fd desc mode = do
  bf <- c_add_fd fd
--  bf' <- c_add_buf bf (-128)
  bf' <- if raw then return bf else c_add_crlf bf
  mkHandle desc bf' (ioModeToHMode mode)

openAsFd :: FilePath -> IOMode -> IO (Maybe Int)
openAsFd name mode = do
  let cm =
        case mode of
          ReadMode      -> 0o0000 -- RDONLY
          WriteMode     -> 0o1101 -- TRUNC, CREAT, WRONLY
          ReadWriteMode -> 0o0002 -- RDWR
          AppendMode    -> 0o2001 -- APPEND, WRONLY
  fd <- withCAString name $ \ cp -> c_open cp cm 0o666
  if fd < 0 then
    return Nothing
   else
    return (Just fd)
