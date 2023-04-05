Object subclass: Formatting [
    | int dec convertedString |
    | command lastChar numConditions valid |
    | testConditions rawCondition splitCondition |
    | shapeList |
    <comment:
        'Object to format to two decimal places'>
    Formatting class >> new [
        | r |
        <category: 'instance creation'>
        r := super new.
        r init.
        ^r
    ]
    init [
        <category: 'initialization'>
        int := 0.
        dec := 0.
        valid := 0.
        convertedString := ''.
        command := ''.
        lastChar := ''.
        numConditions := 0.
    ]
    formatCommand: input [
        <category: 'conversion'>
        lastChar := input at: (input size).
        (lastChar isDigit)
        ifTrue: [
            command := input allButLast: 1.
            numConditions := (lastChar digitValue)
        ]
        ifFalse: [
            command := input.
            numConditions := 0
        ].
        testConditions := Array new: numConditions.
        (command = 'count') ifTrue: [ valid := 1 ].
        (command = 'print') ifTrue: [ valid := 1 ].
        (command = 'total') ifTrue: [ valid := 1 ].
        (command = 'min') ifTrue: [ valid := 1 ].
        (command = 'max') ifTrue: [ valid := 1 ].
        (command = 'avg') ifTrue: [ valid := 1 ].
        (command = 'help') ifTrue: [ valid := 1 ].
        (command = 'quit') ifTrue: [ valid := 1 ].
    ]
    convertToString: number [
        <category: 'conversion'>
        int := number floor.
        dec := ((number rem: 1) * 100) rounded.
        (dec = 0)
        ifTrue: [convertedString := (int printString), '.00']
        ifFalse: [
            (dec < 10)
            ifTrue: [convertedString := (int printString), '.', '0', (dec printString)]
            ifFalse: [convertedString := (int printString), '.', (dec printString)].
        ].
        ^convertedString.
    ]
    getCommand [
        ^command.
    ]
    setTestConditions [
        1 to: (numConditions) do: [:index |
            ('Enter test condition #', (index printString), ': ') display.
            rawCondition := stdin nextLine.
            splitCondition := rawCondition substrings.
            testConditions at: index put: splitCondition.
        ].
    ]
    setShapeList: shapes [
        shapeList := shapes.
    ]
    getTestConditions [
        ^testConditions.
    ]
    getValid [
        ^valid.
    ]
    getShapeList [
        ^shapeList.
    ]
].


(((Smalltalk arguments) size) = 0)
ifTrue: [ 'Usage: shape.st sphere.st cylinder.st torus.st box.st -f main.st shapes_file' displayNl ]
ifFalse: [
    | f |
    [
        f := FileStream open: (Smalltalk arguments at: 1) mode: FileStream read.
    ] on: Exception do: [ :ex |
        ('Unable to open ', (Smalltalk arguments at: 1), ' for reading') displayNl.
        Smalltalk halt.
    ].
    shapes := OrderedCollection new.
    [f atEnd] whileFalse: [
        line := f nextLine.
        split := line substrings.
        ((split at: 2) = 'box')
        ifTrue: [
            newBox := Box new.
            newBox setName: (split at: 1).
            newBox setType: 'box'.
            newBox setL: (split at: 3).
            newBox setW: (split at: 4).
            newBox setH: (split at: 5).
            newBox calculate.
            shapes add: newBox.
        ].
        ((split at: 2) = 'cylinder')
        ifTrue: [
            newCylinder := Cylinder new.
            newCylinder setName: (split at: 1).
            newCylinder setType: 'cylinder'.
            newCylinder setR: (split at: 3).
            newCylinder setH: (split at: 4).
            newCylinder calculate.
            shapes add: newCylinder.
        ].
        ((split at: 2) = 'sphere')
        ifTrue: [
            newSphere := Sphere new.
            newSphere setName: (split at: 1).
            newSphere setType: 'sphere'.
            newSphere setR: (split at: 3).
            newSphere calculate.
            shapes add: newSphere.
        ].
        ((split at: 2) = 'torus')
        ifTrue: [
            newTorus := Torus new.
            newTorus setName: (split at: 1).
            newTorus setType: 'torus'.
            newTorus setSR: (split at: 3).
            newTorus setBR: (split at: 4).
            newTorus calculate.
            shapes add: newTorus.
        ].
    ].
    f close.

    quit := OrderedCollection new.
    quit add: 0.
    queries := OrderedCollection new.
    toRemove := OrderedCollection new.
    [(quit last) = 0] whileTrue: [
        " Initialize query variables "
        text := String new.
        query := Formatting new.

        " Get the input "
        'Enter a command: ' display.
        input := stdin nextLine.
        text := input deepCopy.
        query formatCommand: text.
        queries add: query.
        
        ((queries last) getValid = 0)
        ifTrue: [
            (((queries last) getCommand), ': invalid action') displayNl.
            'Valid actions: print count min max total avg' displayNl.
            'Enter help for help' displayNl.
            '' displayNl.
        ]
        ifFalse: [
            shapeList := shapes deepCopy.
            ((queries last) setShapeList: shapeList).
            (queries last) setTestConditions.
            ((queries last) getTestConditions) do: [ :each |
                toRemove empty.
                ((queries last) getShapeList) do: [ :shape |
                    parameter := ''.
                    value := ''.
                    ((each at: 1) = 'type') ifTrue: [
                        parameter := shape getType.
                        value := (each at: 3).
                    ].
                    ((each at: 1) = 'area') ifTrue: [
                        parameter := shape getArea.
                        value := (each at: 3) asNumber.
                    ].
                    ((each at: 1) = 'volume') ifTrue: [
                        parameter := shape getVolume.
                        value := (each at: 3) asNumber.
                    ].
                    ((each at: 2) = '<') ifTrue: [
                        (parameter < value) ifFalse: [
                            toRemove add: shape.
                        ].
                    ].
                    ((each at: 2) = '>') ifTrue: [
                        (parameter > value) ifFalse: [
                            toRemove add: shape.
                        ].
                    ].
                    ((each at: 2) = '<=') ifTrue: [
                        (parameter <= value) ifFalse: [
                            toRemove add: shape.
                        ].
                    ].
                    ((each at: 2) = '>=') ifTrue: [
                        (parameter >= value) ifFalse: [
                            toRemove add: shape.
                        ].
                    ].
                    ((each at: 2) = '==') ifTrue: [
                        (parameter = value) ifFalse: [
                            toRemove add: shape.
                        ].
                    ].
                    ((each at: 2) = '!=') ifTrue: [
                        (parameter ~= value) ifFalse: [
                            toRemove add: shape.
                        ].
                    ].
                ].
                toRemove do: [ :shape | ((queries last) getShapeList) identityRemove: shape].
            ].


            command := ((queries last) getCommand).
            (command = 'count')
            ifTrue: [
                ('There are ', (((queries last) getShapeList) size printString), ' shapes.') displayNl.
                '' displayNl.
            ].
            (command = 'print')
            ifTrue: [
                ((queries last) getShapeList) do: [ :shape | shape printAttr].
                '' displayNl.
            ].
            (command = 'max')
            ifTrue: [
                maxArea := 0.
                maxVolume := 0.
                ((queries last) getShapeList) do: [ :shape |
                    (shape getArea > maxArea) ifTrue: [maxArea := shape getArea].
                    (shape getVolume > maxVolume) ifTrue: [maxVolume := shape getVolume].
                ].
                maxAreaString := query convertToString: maxArea.
                maxVolumeString := query convertToString: maxVolume.
                ('max(Surface Area)=', maxAreaString) displayNl.
                ('max(Volume)=', maxVolumeString) displayNl.
                '' displayNl.
            ].
            (command = 'min')
            ifTrue: [
                minArea := (((queries last) getShapeList) first) getArea.
                minVolume := (((queries last) getShapeList) first) getVolume.
                ((queries last) getShapeList) do: [ :shape |
                    (shape getArea < minArea) ifTrue: [minArea := shape getArea].
                    (shape getVolume < minVolume) ifTrue: [minVolume := shape getVolume].
                ].
                minAreaString := query convertToString: minArea.
                minVolumeString := query convertToString: minVolume.
                ('min(Surface Area)=', minAreaString) displayNl.
                ('min(Volume)=',minVolumeString) displayNl.
                '' displayNl.
            ].
            (command = 'total')
            ifTrue: [
                totalArea := 0.
                totalVolume := 0.
                ((queries last) getShapeList) do: [ :shape |
                    totalArea := totalArea + (shape getArea).
                    totalVolume := totalVolume + (shape getVolume).
                ].
                totalAreaString := query convertToString: totalArea.
                totalVolumeString := query convertToString: totalVolume.
                ('total(Surface Area)=', totalAreaString) displayNl.
                ('total(Volume)=',totalVolumeString) displayNl.
                '' displayNl.
            ].
            (command = 'avg')
            ifTrue: [
                totalArea := 0.
                totalVolume := 0.
                ((queries last) getShapeList) do: [ :shape |
                    totalArea := totalArea + (shape getArea).
                    totalVolume := totalVolume + (shape getVolume).
                ].
                avgArea := totalArea / (((queries last) getShapeList) size).
                avgVolume := totalVolume / (((queries last) getShapeList) size).
                avgAreaString := query convertToString: avgArea.
                avgVolumeString := query convertToString: avgVolume.
                ('avg(Surface Area)=', avgAreaString) displayNl.
                ('avg(Volume)=', avgVolumeString) displayNl.
                '' displayNl.
            ].
            (command = 'help')
            ifTrue: [

                (Character tab asString, 'count') displayNl.
                (Character tab asString, '*** print the number of all shapes') displayNl.
                (Character tab asString, 'countN') displayNl.
                (Character tab asString, '*** print the number of all shapes that satisfy all N conditions specified below') displayNl.
                (Character tab asString, '*** for example: count3') displayNl.
                (Character tab asString, 'print') displayNl.
                (Character tab asString, '*** print all shapes') displayNl.
                (Character tab asString, 'printN') displayNl.
                (Character tab asString, '*** print all shapes that satisfy all N conditions specified below') displayNl.
                (Character tab asString, '*** for example: print4') displayNl.
                (Character tab asString, 'min') displayNl.
                (Character tab asString, '*** find the minimum surface area and volume of all shapes') displayNl.
                (Character tab asString, 'minN') displayNl.
                (Character tab asString, '*** find the minimum surface area and volume of all shapes that satisfy all N conditions specified below') displayNl.
                (Character tab asString, '*** for example: min2') displayNl.
                (Character tab asString, 'max') displayNl.
                (Character tab asString, '*** find the maximum surface area and volume of all shapes') displayNl.
                (Character tab asString, 'maxN') displayNl.
                (Character tab asString, '*** find the maximum surface area and volume of all shapes that satisfy all N conditions specified below') displayNl.
                (Character tab asString, '*** for example: max3') displayNl.
                (Character tab asString, 'total') displayNl.
                (Character tab asString, '*** find the tatal surface area and volume of all shapes') displayNl.
                (Character tab asString, 'totalN') displayNl.
                (Character tab asString, '*** find the total surface area and volume of all shapes that satisfy all N conditions specified below') displayNl.
                (Character tab asString, '*** for example: total4') displayNl.
                (Character tab asString, 'avg') displayNl.
                (Character tab asString, '*** find the average surface area and volume of all shapes') displayNl.
                (Character tab asString, 'avgN') displayNl.
                (Character tab asString, '*** find the average surface area and volume of all shapes that satisfy all N conditions specified below') displayNl.
                (Character tab asString, '*** for example: avg2') displayNl.
                (Character tab asString, 'quit') displayNl.
                (Character tab asString, '*** quit this program') displayNl.
                (Character tab asString, 'help') displayNl.
                (Character tab asString, '*** print this list') displayNl.
                '' displayNl.
                ('Each condition shall be entered in one line and of the following format:') displayNl.
                '' displayNl.
                (Character tab asString, 'name op value') displayNl.
                '' displayNl.
                (Character tab asString, '*** for example: type != box') displayNl.
                (Character tab asString, '                 area <= 1000') displayNl.
                (Character tab asString, '                 volume > 100.5') displayNl.
                '' displayNl.
                (Character tab asString, 'The valid names:') displayNl.
                (Character tab asString, 'type') displayNl.
                (Character tab asString, 'area') displayNl.
                (Character tab asString, 'name') displayNl.
                '' displayNl.
                (Character tab asString, 'The valid operators:') displayNl.
                (Character tab asString, '==') displayNl.
                (Character tab asString, '!=') displayNl.
                (Character tab asString, '>=') displayNl.
                (Character tab asString, '<=') displayNl.
                (Character tab asString, '>') displayNl.
                (Character tab asString, '<') displayNl.
                '' displayNl.
                '' displayNl.
            ].
            (command = 'quit')
            ifTrue: [
                quit add: 1.
            ].
        ].
    ].
].