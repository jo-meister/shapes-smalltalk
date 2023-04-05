Shape subclass: Sphere [
    | radius |
    | radiusString |
    init [
        <category: 'initialization'>
        radius := 0.
        ^super init
    ]
    setR: r [
        radius := r asNumber.
        int := radius floor.
        dec := ((radius rem: 1) * 100) rounded.
        (dec = 0)
        ifTrue: [radiusString := (int printString), '.00']
        ifFalse: [
            (dec < 10)
            ifTrue: [radiusString := (int printString), '.0', (dec printString)]
            ifFalse: [radiusString := (int printString), '.', (dec printString)].
        ].
    ]
    calculate [
        volume := 4 * pi * radius * radius * radius / 3.
        int := volume floor.
        dec := ((volume rem: 1) * 100) rounded.
        (dec = 0)
        ifTrue: [volumeString := (int printString), '.00']
        ifFalse: [
            (dec < 10)
            ifTrue: [volumeString := (int printString), '.0', (dec printString)]
            ifFalse: [volumeString := (int printString), '.', (dec printString)].
        ].
        area := 4 * pi * radius * radius.
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
        ('Sphere: ', name, ', Radius=', radiusString) displayNl.
        (Character tab asString, 'Surface Area: ', areaString, ', Volume: ', volumeString) displayNl.
    ]
]