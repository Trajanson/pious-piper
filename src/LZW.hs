module LZW where

import qualified Data.Map  as Map
import qualified Data.Char as Char
import Data.Maybe



startingASCIIToIntegerDictionary :: Map.Map [Char] Integer
startingASCIIToIntegerDictionary = Map.fromList [tupelize x | x <- [1..127] ]
  where tupelize x = ([Char.chr x], toInteger x)




lzwCompress :: String -> [Integer]
lzwCompress text = forwardCompression (startingASCIIToIntegerDictionary) text [] []



-- CONDITIONS
-- REMAINING TEXT IS EMPTY
    -- IF NO TEXT IN BUFFER  -----------> RETURN ACCUMULATED COMPRESSION
    -- IF TEXT IN BUFFER
        -- IF IN DICTIONARY     --------> PUSH COMPRESSED BUFFER INTO ACCUM
        --                      --------> RETURN
        --
        -- IF NOT IN DICTIONARY --------> PUSH COMPRESSED INIT INTO ACCUM
        --                      --------> CALL AGAIN
-- REMAINING TEXT IS FULL
    -- IF NO TEXT IN BUFFER  ------------> MOVE HEAD OF REMAIN TEXT TO BUFFER
    --                       ------------> CALL AGAIN
    -- IF TEXT IN BUFFER
        -- IF IN DICTIONARY  ------------> APPEND HEAD OF TEXT ONTO BUFFER
        --                   ------------> CALL AGAIN
        --
        --------------------------------------------------------------------------------
        -- IF NOT IN DICTIONARY ---------> PUSH COMPRESSED INIT INTO ACCUM
        --                      ---------> CALL AGAIN






--                 dictionary remainingText textInBuffer accumulatedCompression
forwardCompression dictionary []            []           accumulatedCompression = accumulatedCompression
forwardCompression dictionary []            textInBuffer accumulatedCompression
    | Map.member textInBuffer dictionary =
                                           ( accumulatedCompression ++
                                             [compressBuffer dictionary textInBuffer]
                                           )
    | otherwise                          = forwardCompression dictionary
                                                              []
                                                              [last textInBuffer]
                                                              (accumulatedCompression ++
                                                                [compressBuffer dictionary (init textInBuffer)]
                                                              )
forwardCompression dictionary remainingText []           accumulatedCompression = forwardCompression dictionary
                                                                                                     (tail remainingText)
                                                                                                     [head remainingText]
                                                                                                     accumulatedCompression
forwardCompression dictionary remainingText textInBuffer accumulatedCompression
    | Map.member textInBuffer dictionary = forwardCompression dictionary
                                                              (tail remainingText)
                                                              (textInBuffer ++ [head remainingText])
                                                              accumulatedCompression
    | otherwise =                          forwardCompression (Map.insert (textInBuffer)
                                                                      ((toInteger $ Map.size dictionary) + 1)
                                                                      dictionary
                                                              )
                                                              (remainingText)
                                                              ([last textInBuffer])
                                                              (accumulatedCompression ++ [compressBuffer dictionary (init textInBuffer)])

compressBuffer dictionary textInBuffer
 | otherwise = fromJust (Map.lookup textInBuffer dictionary)
















startingIntegerToASCIIDictionary :: Map.Map Integer [Char]
startingIntegerToASCIIDictionary = Map.fromList [tupelize x | x <- [1..127] ]
 where tupelize x = (toInteger x, [Char.chr x])





-- lzwDecompress :: [Integer] -> String
lzwDecompress charCodes = forwardDecompression (startingIntegerToASCIIDictionary) charCodes [] []




-------------------------------------------------------------------------------
-------------------------------------------------------------------------------
-------------------------------------------------------------------------------
-------------------------------------------------------------------------------
-------------------------------------------------------------------------------
-- CONVERT BUFFER TO CODES NOT LETTERS
-------------------------------------------------------------------------------
-------------------------------------------------------------------------------
-------------------------------------------------------------------------------
-------------------------------------------------------------------------------
-------------------------------------------------------------------------------


 --                  dictionary remainingCharCodes buffer accumulatedText
-- forwardDecompression dictionary []                 buffer accumulatedText = accumulatedText
forwardDecompression dictionary []                 buffer accumulatedText = accumulatedText
forwardDecompression dictionary remainingCharCodes []     accumulatedText = forwardDecompression dictionary
                                                                                                 (tail remainingCharCodes)
                                                                                                 [head remainingCharCodes]
                                                                                                 (accumulatedText ++ (decompressBuffer dictionary (head remainingCharCodes)))
forwardDecompression dictionary remainingCharCodes buffer accumulatedText
  | length buffer == 2  = forwardDecompression (Map.insert ((toInteger $ Map.size dictionary) + 1)
                                                           ( (decompressBuffer dictionary (head buffer)) ++
                                                              [head $ decompressBuffer dictionary (last buffer)]
                                                           )
                                                           dictionary)
                                               (remainingCharCodes)
                                               (tail buffer)
                                               (accumulatedText)
  | length buffer == 1  = forwardDecompression dictionary
                                               (tail remainingCharCodes)
                                               (buffer ++ [head remainingCharCodes] )
                                               (accumulatedText ++ (decompressBuffer dictionary (head remainingCharCodes)))























lzwBuildDictionary charCodes = forwardBuildDictionary (startingIntegerToASCIIDictionary) charCodes [] []


forwardBuildDictionary dictionary []                 buffer accumulatedText = dictionary
forwardBuildDictionary dictionary remainingCharCodes []     accumulatedText = forwardBuildDictionary dictionary
                                                                                                (tail remainingCharCodes)
                                                                                                [head remainingCharCodes]
                                                                                                (accumulatedText ++ (decompressBuffer dictionary (head remainingCharCodes)))
forwardBuildDictionary dictionary remainingCharCodes buffer accumulatedText
  | length buffer == 2  = forwardBuildDictionary (Map.insert ((toInteger $ Map.size dictionary) + 1)
                                                           ( (decompressBuffer dictionary (head buffer)) ++
                                                              [head $ decompressBuffer dictionary (last buffer)]
                                                           )
                                                           dictionary)
                                               (remainingCharCodes)
                                               (tail buffer)
                                               (accumulatedText)
  | length buffer == 1  = forwardBuildDictionary dictionary
                                               (tail remainingCharCodes)
                                               (buffer ++ [head remainingCharCodes] )
                                               (accumulatedText ++ (decompressBuffer dictionary (head remainingCharCodes)))










decompressBuffer dictionary code
  | otherwise = fromJust (Map.lookup code dictionary)