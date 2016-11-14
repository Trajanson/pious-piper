module Main where

import Data.String.Strip

import LZW

main :: IO ()
main = print (lzwCompress "aa")
