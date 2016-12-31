module Utilities where

import Control.Parallel.Strategies


runInParallel (firstHalf, secondHalf) func = runEval $ do
    processedFirstHalf  <- rpar (func firstHalf)
    processedSecondHalf <- rpar (func secondHalf)
    return (processedFirstHalf, processedSecondHalf)


splitInHalf :: [a] -> ([a], [a])
splitInHalf lst = splitAt ((length lst) `div` 2) lst
