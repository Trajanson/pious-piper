# [Pious Piper Data Compression Service][piousPiper]

[Pious Piper][piousPiper] is a multi-processor-capable lossless data compression tool. It's exciting [non-]proprietary multi-threaded compression algorithm is derived from an LZW-variant [theorized by Schmuel Klein and Yair Wiseman][kleinWisemanArticle] in the Journal of Discrete Applied Mathematics.


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
