module Main where

import System.Environment
import Control.Parallel.Strategies
import Data.String.Strip

import Utilities
import ReaderWriter
import LZW

main :: IO ()
main = do args <- getArgs
          let filename = head args
          fileContents <- readFile (filename)
          let compressedSplitData = runInParallel (splitInHalf fileContents) lzwCompress
          writeCompressedDataToFile filename compressedSplitData
          print "SUCCESSFULLY COMPRESSED!"

succAll :: String -> String
succAll = map (\a -> succ a)
