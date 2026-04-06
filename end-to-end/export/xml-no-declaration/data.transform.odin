{$}
odin = "1.0.0"
transform = "1.0.0"
direction = "odin->xml"
target.format = "xml"
target.declaration = false
target.rootElement = "data"
description = "Export ODIN to XML without XML declaration"

{$source}
format = "odin"

{person}
name = @person.name
age = @person.age
active = @person.active
