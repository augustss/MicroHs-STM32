module Test1 where
import Control.Concurrent
import System.IO.TimeMilli
import STM32.LED

main :: IO ()
main = do
  forkIO ledLoop
  loop 0

loop :: Int -> IO ()
loop i = do
--  t <- getTimeMilli
  putStrLn $ "Hello " ++ show i
  threadDelay 100_000
  loop (i+1)

ledLoop :: IO ()
ledLoop = do
  toggleLED red
  threadDelay 200_000
  toggleLED blue
  threadDelay 200_000
  toggleLED green
  threadDelay 200_000
  ledLoop

toggleLED :: LED -> IO ()
toggleLED l = do
  b <- getLED l
  setLED l (not b)
