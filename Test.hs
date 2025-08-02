module Test where
import qualified Prelude()
import Control.Concurrent
import System.IO.TimeMilli
--import Prelude hiding(putStrLn)
import STMPrelude
import LED

main :: IO ()
main = do
  forkIO ledLoop
  loop 0

loop :: Int -> IO ()
loop i = do
--  t <- getTimeMilli
  putStrLn $ "Hello " ++ showInt i
  threadDelay 100_000
  loop (i+1)

ledLoop :: IO ()
ledLoop = do
  setLED red True
  threadDelay 200_000
  setLED red False
  threadDelay 200_000
  ledLoop
