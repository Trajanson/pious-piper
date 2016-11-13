dictionary             = {}
remainingText          = 'ab'
textInBuffer           = ''
accumulatedCompression = []

dictionary             = {}
remainingText          = 'b'
textInBuffer           = 'a'   ---- in dictionary so get next
accumulatedCompression = []

dictionary             = {''}
remainingText          = ''
textInBuffer           = 'ab'    ---- not in dictionary so push init into comp accumulatedCompression
accumulatedCompression = []

dictionary             = {'ab: 128'}
remainingText          = ''
textInBuffer           = 'b'
accumulatedCompression = [97]

dictionary             = {'ab: 128'}
remainingText          = ''
textInBuffer           = ''
accumulatedCompression = [97, 98]






dictionary             = {}
remainingText          = 'ababa'
textInBuffer           = ''
accumulatedCompression = []

dictionary             = {}
remainingText          = 'baba'
textInBuffer           = 'a'   ---- in dictionary so get next
accumulatedCompression = []

dictionary             = {}
remainingText          = 'aba'
textInBuffer           = 'ab'   ---- not in dictionary so push init into comp
accumulatedCompression = []

dictionary             = {'ab': 128}
remainingText          = 'aba'
textInBuffer           = 'b'    ---- in dictionary so get next
accumulatedCompression = [97]

dictionary             = {'ab': 128}
remainingText          = 'ba'
textInBuffer           = 'ba'   ---- not in dictionary so push init into comp
accumulatedCompression = [97]

dictionary             = {'ab': 128, 'ba': 129}
remainingText          = 'ba'
textInBuffer           = 'a'    ---- in dictionary so get next
accumulatedCompression = [97, 98]

dictionary             = {'ab': 128, 'ba': 129}
remainingText          = 'a'
textInBuffer           = 'ab'    ---- in dictionary so get next
accumulatedCompression = [97, 98]

dictionary             = {'ab': 128, 'ba': 129}
remainingText          = ''
textInBuffer           = 'aba'    ---- not in dictionary so push init into comp
accumulatedCompression = [97, 98]

dictionary             = {'ab': 128, 'ba': 129, 'aba': 130}
remainingText          = ''
textInBuffer           = 'a'    ---- in dictionary and remaining text is empty
                                ---- so push into compression and finish
accumulatedCompression = [97, 98, 128]
