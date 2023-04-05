Shape subclass: Box [
    | length width height |
    | lengthString widthString heightString |
    init [
        <category: 'initialization'>
        length := 0.
        width := 0.
        height := 0.
        ^super init
    ]
    setL: l [
        length := l asNumber.
        int := length floor.
        dec := ((length rem: 1) * 100) rounded.
        (dec = 0)
        ifTrue: [lengthString := (int printString), '.00']
        ifFalse: [
            (dec < 10)
            ifTrue: [lengthString := (int printString), '.', '0', (dec printString)]
            ifFalse: [lengthString := (int printString), '.', (dec printString)].
        ].
    ]
    setW: w [
        width := w asNumber.
        int := width floor.
        dec := ((width rem: 1) * 100) rounded.
        (dec = 0)
        ifTrue: [widthString := (int printString), '.00']
        ifFalse: [
            (dec < 10)
            ifTrue: [widthString := (int printString), '.', '0', (dec printString)]
            ifFalse: [widthString := (int printString), '.', (dec printString)].
        ].
    ]
    setH: h [
        height := h asNumber.
        int := height floor.
        dec := ((height rem: 1) * 100) rounded.
        (dec = 0)
        ifTrue: [heightString := (int printString), '.00']
        ifFalse: [
            (dec < 10)
            ifTrue: [heightString := (int printString), '.', '0', (dec printString)]
            ifFalse: [heightString := (int printString), '.', (dec printString)].
        ].
    ]
    calculate [
        volume := length * width * height.
        int := volume floor.
        dec := ((volume rem: 1) * 100) rounded.
        (dec = 0)
        ifTrue: [volumeString := (int printString), '.00']
        ifFalse: [
            (dec < 10)
            ifTrue: [volumeString := (int printString), '.0', (dec printString)]
            ifFalse: [volumeString := (int printString), '.', (dec printString)].
        ].
        area := (length * width * 2) + (length * height * 2) + (width * height * 2).
        int := area floor.
        dec := ((area rem: 1) * 100) rounded.
        (dec = 0)
        ifTrue: [areaString := (int printString), '.00']
        ifFalse: [
            (dec < 10)
            ifTrue: [areaString := (int printString), '.', '0', (dec printString)]
            ifFalse: [areaString := (int printString), '.', (dec printString)].
        ].
    ]
    printAttr [
        ('Box: ', name, ', Length=', lengthString, ', Width=', widthString, ', Height=', heightString) displayNl.
        (Character tab asString, 'Surface Area: ', areaString, ', Volume: ', volumeString) displayNl.
    ]
]