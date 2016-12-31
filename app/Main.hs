module Main where

import Control.Parallel.Strategies

import Data.String.Strip

import LZW

main :: IO ()
main = print (lzwCompress "aa")
