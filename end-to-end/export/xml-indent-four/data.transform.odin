{$}
odin = "1.0.0"
transform = "1.0.0"
direction = "odin->xml"
target.format = "xml"
target.declaration = true
target.indent = ##4
target.rootElement = "data"
description = "Export ODIN to XML with 4-space indentation"

{$source}
format = "odin"

{person}
name = @person.name
age = @person.age

{address}
city = @address.city
state = @address.state
