Object subclass: Shape [
    | name type |
    | pi |
    | area volume |
    | areaString volumeString |
    | int dec |
    <comment:
        'Base class for all shapes'>
    Shape class >> new [
        | r |
        <category: 'instance creation'>
        r := super new.
        r init.
        ^r
    ]
    init [
        <category: 'initialization'>
        name := ''.
        type := ''.
        area := 0.
        volume := 0.
        pi := 3.14159265358979323846e0.
    ]
    setName: new_name [
        <category: 'name'>
        name := new_name.
    ]
    setType: new_type [
        <category: 'type'>
        type := new_type.
    ]
    getName [
        ^name.
    ]
    getType [
        ^type.
    ]
    getArea [
        ^area.
    ]
    getVolume [
        ^volume.
    ]
]