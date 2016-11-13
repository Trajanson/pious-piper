module LZW where

import qualified Data.Map  as Map
import qualified Data.Char as Char
import Data.Maybe


startingASCIIDictionary :: Map.Map [Char] Integer
startingASCIIDictionary = Map.fromList [tupelize x | x <- [1..127] ]
  where tupelize x = ([Char.chr x], toInteger x)




lzwCompress :: String -> [Integer]
lzwCompress text = forwardCompression (startingASCIIDictionary) text [] []


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
    | Map.member textInBuffer dictionary = ( accumulatedCompression ++
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
