To compress file:

$ stack exec compress file.txt


To decompress file (will search for "compressed-originalFileName" in ./files/outputs/compressed/):

$ stack exec decompress originalFileName.txt



To run tests:

$ stack test

Compresses TaleOfTwoCities.txt from 74,111 bytes to 44,891 bytes.
