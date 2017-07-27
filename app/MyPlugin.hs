module MyPlugin where

import Prelude
import Data.Time

foo :: IO [UTCTime]
foo = do
  x <- getCurrentTime
  return $ zipWith (\tm d -> addUTCTime (fromIntegral d) tm) (replicate 10000 x) [1..]

