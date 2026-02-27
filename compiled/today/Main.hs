module Main where

import Data.Time (getCurrentTime)
import Data.Time.Format.ISO8601 (iso8601Show)

main :: IO ()
main = do
  now <- getCurrentTime
  putStrLn $ iso8601Show now
