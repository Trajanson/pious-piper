module Main where

import System.Environment

import Data.String.Strip

import LZW

main :: IO ()
main = do args <- getArgs
          fileContents <- readFile (head args)
          print $ lzwCompress fileContents
