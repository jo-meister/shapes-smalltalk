Shape subclass: Cylinder [
    | radius height |
    | radiusString heightString |
    init [
        <category: 'initialization'>
        radius := 0.
        height := 0.
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
    setH: h [
        height := h asNumber.
        int := height floor.
        dec := ((height rem: 1) * 100) rounded.
        (dec = 0)
        ifTrue: [heightString := (int printString), '.00']
        ifFalse: [
            (dec < 10)
            ifTrue: [heightString := (int printString), '.0', (dec printString)]
            ifFalse: [heightString := (int printString), '.', (dec printString)].
        ].
    ]
    calculate [
        volume := pi * radius * radius * height.
        int := volume floor.
        dec := ((volume rem: 1) * 100) rounded.
        (dec = 0)
        ifTrue: [volumeString := (int printString), '.00']
        ifFalse: [
            (dec < 10)
            ifTrue: [volumeString := (int printString), '.0', (dec printString)]
            ifFalse: [volumeString := (int printString), '.', (dec printString)].
        ].
        area := (2 * pi * radius * radius) + (2 * pi * radius * height).
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
        ('Cylinder: ', name, ', Radius=', radiusString, ', Height=', heightString) displayNl.
        (Character tab asString, 'Surface Area: ', areaString, ', Volume: ', volumeString) displayNl.
    ]
]