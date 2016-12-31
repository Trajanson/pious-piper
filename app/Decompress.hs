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
          fileContents <- readCompressedDataFromFile filename
          let compressedDataAsIntegers = getCompressedDataAsIntegers fileContents
          let compressedSplitData = splitCompressedIntegersOnDividerValue compressedDataAsIntegers

          let decompressedSplitText = runInParallel compressedSplitData lzwDecompress

          writeDecompressedTextToFile filename decompressedSplitText

          print "SUCCESSFULLY DECOMPRESSED!"


succAll :: String -> String
succAll = map (\a -> succ a)
