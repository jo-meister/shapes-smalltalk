Shape subclass: Torus [
    | smallRadius bigRadius |
    | smallRadiusString bigRadiusString |
    init [
        <category: 'initialization'>
        smallRadius := 0.
        bigRadius := 0.
        ^super init
    ]
    setSR: smallR [
        smallRadius := smallR asNumber.
        int := smallRadius floor.
        dec := ((smallRadius rem: 1) * 100) rounded.
        (dec = 0)
        ifTrue: [smallRadiusString := (int printString), '.00']
        ifFalse: [
            (dec < 10)
            ifTrue: [smallRadiusString := (int printString), '.0', (dec printString)]
            ifFalse: [smallRadiusString := (int printString), '.', (dec printString)].
        ].
    ]
    setBR: bigR [
        bigRadius := bigR asNumber.
        int := bigRadius floor.
        dec := ((bigRadius rem: 1) * 100) rounded.
        (dec = 0)
        ifTrue: [bigRadiusString := (int printString), '.00']
        ifFalse: [
            (dec < 10)
            ifTrue: [bigRadiusString := (int printString), '.0', (dec printString)]
            ifFalse: [bigRadiusString := (int printString), '.', (dec printString)].
        ].
    ]
    calculate [
        volume := pi * smallRadius * smallRadius * 2 * pi * bigRadius.
        int := volume floor.
        dec := ((volume rem: 1) * 100) rounded.
        (dec = 0)
        ifTrue: [volumeString := (int printString), '.00']
        ifFalse: [
            (dec < 10)
            ifTrue: [volumeString := (int printString), '.0', (dec printString)]
            ifFalse: [volumeString := (int printString), '.', (dec printString)].
        ].
        area := 2 * pi * smallRadius * 2 * pi * bigRadius.
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
        ('Torus: ', name, ', smallRadius=', smallRadiusString, ', bigRadius=', bigRadiusString) displayNl.
        (Character tab asString, 'Surface Area: ', areaString, ', Volume: ', volumeString) displayNl.
    ]
]