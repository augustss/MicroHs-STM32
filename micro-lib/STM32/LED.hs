module STM32.LED(LED, red, green, blue, setLED, getLED) where
--import qualified Prelude()
--import Primitives(Ptr)
--import Data.Functor
import Foreign(Ptr)

data GPIO

foreign import ccall "gpio.h value red_led"    red_led :: Ptr GPIO
foreign import ccall "gpio.h value blue_led"   blue_led :: Ptr GPIO
foreign import ccall "gpio.h value green_led"  green_led :: Ptr GPIO
foreign import ccall "gpio.h set_led"          set_led :: Ptr GPIO -> Int -> IO ()
foreign import ccall "gpio.h read_led"         read_led :: Ptr GPIO -> IO Int

newtype LED = LED (Ptr GPIO)

red, green, blue :: LED
red   = LED red_led
green = LED green_led
blue  = LED blue_led

setLED :: LED -> Bool -> IO ()
setLED (LED p) b = set_led p (if b then 1 else 0)

getLED :: LED -> IO Bool
getLED (LED p) = (1 ==) <$> read_led p
