module Example where
import qualified Prelude()
import STMPrelude

data GPIO

foreign import ccall "gpio.h value red_led"    red_led :: Ptr GPIO
foreign import ccall "gpio.h value blue_led"   blue_led :: Ptr GPIO
foreign import ccall "gpio.h value green_led"  green_led :: Ptr GPIO
foreign import ccall "gpio.h set_led"          set_led :: Ptr GPIO -> Int -> IO ()
foreign import ccall "gpio.h read_led"         read_led :: Ptr GPIO -> IO Int
foreign import ccall "gpio.h toggle_led"       toggle_led :: Ptr GPIO -> IO ()
foreign import ccall "timer.h delay_ms"        c_delay :: Int -> IO ()

{-
blink :: Int -> [Ptr GPIO] -> [Int] -> IO ()
blink 0 _ _ = return ()
blink n (c:cs) (i:is) = do
  set_led c i
  putStrLn "Hello Robert!"
  c_delay 200 -- ms delay
  blink (n-1) cs is
blink _ _ _ = error "blink"

main :: IO ()
main = blink 20 (cycle [red_led, blue_led, green_led]) (cycle [0::Int,1::Int])
-}

blink :: [Ptr GPIO] -> [Int] -> IO ()
blink (c:cs) (i:is) = do
  set_led c i
  putStrLn "Hello Robert!"
  c_delay 200 -- ms delay
  blink cs is
blink _ _ = error "blink"

main :: IO ()
main = blink (cycle [red_led, blue_led, green_led]) (cycle [0::Int,1::Int])
