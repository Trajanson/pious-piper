module LZW where

import qualified Data.Map  as Map
import qualified Data.Char as Char
import Data.Maybe


startingASCIIDictionary :: Map.Map [Char] Integer
startingASCIIDictionary = Map.fromList [tupelize x | x <- [1..127] ]
  where tupelize x = ([Char.chr x], toInteger x)



lzwCompress :: String -> [Integer]
lzwCompress text = go (startingASCIIDictionary) text [] []
  where go dictionary [] [] accumulatedCompression = accumulatedCompression
        go dictionary (x:[]) [] accumulatedCompression = go dictionary [] [x] accumulatedCompression
        go dictionary (x:remainingText) [] accumulatedCompression = go dictionary (remainingText) [x] accumulatedCompression
        go dictionary remainingText textInBuffer accumulatedCompression
         | otherwise = go dictionary (remainingText) [] (accumulatedCompression ++ [compressBuffer dictionary textInBuffer])
        compressBuffer dictionary textInBuffer
         | otherwise = fromJust (Map.lookup textInBuffer dictionary)
