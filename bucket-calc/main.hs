main :: IO ()
main = do
  let start = 1 :: Double
      endVal = 100000 :: Double
      numBins = 20 :: Int
      logBase' = (endVal / start) ** (1 / fromIntegral numBins)
      binEdges = [start * logBase' ** fromIntegral i | i <- [0..numBins]]
      binEdgesInt = map round binEdges :: [Int]
  print binEdgesInt
