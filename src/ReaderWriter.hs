module ReaderWriter where

import qualified Data.ByteString as B
import System.FilePath.Windows
import Data.Word
import Data.List.Split


compressedFileOutputLocation :: String
compressedFileOutputLocation = "./files/outputs/compressed/"

decompressedFileOutputLocation :: String
decompressedFileOutputLocation = "./files/outputs/decompressed/"

dividerValue :: Integer
dividerValue = 0


writeDecompressedTextToFile filename splitText = do
    print fileLocation
    writeFile fileLocation text
  where text :: String
        text = fst splitText ++ snd splitText
        fileLocation :: String
        fileLocation = decompressedFileOutputLocation ++ "decompressed-" ++  (takeFileName filename)


splitCompressedIntegersOnDividerValue :: [Integer] -> ([Integer], [Integer])
splitCompressedIntegersOnDividerValue integerData = (head listOfParallelData, last listOfParallelData)
  where listOfParallelData :: [[Integer]]
        listOfParallelData = splitOn [0] integerData


getCompressedDataAsIntegers :: B.ByteString -> [Integer]
getCompressedDataAsIntegers fileContents = convertListOf8BytesToListOfIntegers bytes bytesPerIntegerAsInteger
  where bytesPerInteger :: Word8
        bytesPerInteger = B.head fileContents
        bytesPerIntegerAsInteger :: Integer
        bytesPerIntegerAsInteger = fromIntegral (bytesPerInteger :: Word8) :: Integer
        fileData :: B.ByteString
        fileData = B.tail fileContents
        bytes :: [Word8]
        bytes = B.unpack fileData





readCompressedDataFromFile :: String -> IO B.ByteString
readCompressedDataFromFile filename = B.readFile filename









writeCompressedDataToFile filename compressedData = B.writeFile compressedFileLocation bytes
  where compressedFileLocation = compressedFileOutputLocation ++ "compressed-" ++  (takeFileName filename)
        bytes = B.pack $ convertListOfIntegersToListof8Bytes $ mergeCompressedData compressedData

mergeCompressedData :: ([Integer], [Integer]) -> [Integer]
mergeCompressedData (firstHalf, secondHalf) = firstHalf ++ [dividerValue] ++ secondHalf





convertListOfIntegersToListof8Bytes :: [Integer] -> [Word8]
convertListOfIntegersToListof8Bytes nums = bytesPerIntegerAsByte : concatMap (convertIntegerTo8Bytes bytesPerInteger) nums
  where largestInteger :: Integer
        largestInteger = maximum nums
        bytesPerInteger :: Integer
        bytesPerInteger = bytesNeededForInteger largestInteger
        bytesPerIntegerAsByte :: Word8
        bytesPerIntegerAsByte = fromInteger (bytesPerInteger :: Integer) :: Word8

bytesNeededForInteger :: Integer -> Integer
bytesNeededForInteger num = go num 0
  where go :: Integer -> Integer -> Integer
        go num count
         | num == 0 && count == 0 = 1
         | num == 0 = count
         | otherwise = go ( num `div` 256 )
                          ( count + 1 )


convertIntegerTo8Bytes :: Integer -> Integer -> [Word8]
convertIntegerTo8Bytes maxNumBytes num = go maxNumBytes num []
    where go remainingBytes remainingNum accumBytes
            | remainingBytes == 0 = accumBytes
            | otherwise = go ( remainingBytes - 1 )
                             ( remainingNum `div` 256 )
                             ( convertToWord8 (remainingNum `mod` 256) : accumBytes )
          convertToWord8 int = fromInteger (int :: Integer) :: Word8





convertListOf8BytesToListOfIntegers :: [Word8] -> Integer -> [Integer]
convertListOf8BytesToListOfIntegers bytes bytesPerInteger = go bytes bytesPerInteger []
    where go :: [Word8] -> Integer -> [Integer] -> [Integer]
          go [] bytesPerInteger accum = accum
          go remainingBytes bytesPerInteger accum = go ( drop (fromIntegral bytesPerInteger) remainingBytes )
                                                       ( bytesPerInteger )
                                                       ( accum ++ [bytesToInteger bytesPerInteger remainingBytes] )
          bytesToInteger :: Integer -> [Word8] -> Integer
          bytesToInteger bytesPerInteger remainingBytes = convert8BytesToInteger (take (fromIntegral bytesPerInteger) remainingBytes)











convert8BytesToInteger :: [Word8] -> Integer
convert8BytesToInteger bytes = go bytes 1 0
    where go :: [Word8] -> Integer -> Integer -> Integer
          go [] base total = total
          go remainingBytes base total = go ( init remainingBytes )
                                            ( base * 256 )
                                            ( total + (base * convertToInteger(last remainingBytes)) )
          convertToInteger word8 = fromIntegral (word8 :: Word8) :: Integer
