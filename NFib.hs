module NFib(main, nfib) where
import System.IO.TimeMilli(getTimeMilli)

nfib :: Int -> Int
nfib n =
  case n < 2 of
    False -> nfib (n - 1) + nfib (n - 2) + 1
    True  -> 1

main :: IO ()
main = do
  nfibIO 22

nfibIO :: Int -> IO ()
nfibIO n = do
  t1 <- getTimeMilli
  let r = nfib n
  print r
  t2 <- getTimeMilli
  putStrLn $ "nfib/s = " ++ show (r `quot` (t2 - t1)) ++ "k"
