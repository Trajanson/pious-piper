# [Pious Piper Data Compression Service][piousPiper]

[Pious Piper][piousPiper] is a multi-processor-capable lossless data compression tool. It's exciting [non-]proprietary multi-threaded compression algorithm is derived from an LZW-variant [theorized by Schmuel Klein and Yair Wiseman][kleinWisemanArticle] in the Journal of Discrete Applied Mathematics.

#### Explanation of Implementation

LZW compression is an on-the-fly compression algorithm. It starts with a dictionary that maps ASCII characters to numbers. As groups of characters are encountered, these characters are grouped together and given a new code beyond that of the ASCII range. A benefit of this method of determining encoding patterns is that the mapping of patterns to codes, which must be conserved for the sake of compression, is derived based on the frequency of patterns in the text.

LZW decompression works the same way in reverse. As ASCII characters are encountered in the compressed code, their groupings are used to create new mappings of characters to codes.

The multi-threading component of this algorithm is implemented by dividing splitting the encoded pattern by a pre-determined code and then running the decompression algorithm in parallel with read-heads along the two seperate segments of the encoding.

#### Requirements
- **[Follow this link to install Haskell][installHaskell]**

#### Use and Instructions

##### To compress files:

`$ stack exec compress file.txt`


##### To decompress file (will search for "compressed-originalFileName" in ./files/outputs/compressed/):

`$ stack exec decompress originalFileName.txt`


##### To run tests:

`$ stack test`


#### Results

##### TaleOfTwoCities.txt before compression:
![initialFileSizeTaleOfTwoCities]

##### TaleOfTwoCities.txt after Pious Piper compression:
![compressedFileSizeTaleOfTwoCities]

##### Space Reduction
![spaceSavings]

## Technologies Used

* [Haskell][haskell]
* [HSpec Testing Framework][hspec]
* [Multi-Threaded Processing][multiThreadedProcessing]
* [Stack][stack]




[piousPiper]: https://github.com/Trajanson/pious-piper
[kleinWisemanArticle]: http://u.cs.biu.ac.il/~wiseman/dam2005.pdf
[installHaskell]: https://www.haskell.org/platform/

[initialFileSizeTaleOfTwoCities]: ./docs/InitialFileSizeTaleOfTwoCities.png
[compressedFileSizeTaleOfTwoCities]: ./docs/CompressedFileSizeTaleOfTwoCities.png
[spaceSavings]: ./docs/SpaceSavings.png

[haskell]: https://www.haskell.org/
[hspec]: http://hspec.github.io/
[multiThreadedProcessing]: https://wiki.haskell.org/Concurrency
[stack]: https://docs.haskellstack.org/en/stable/README/
