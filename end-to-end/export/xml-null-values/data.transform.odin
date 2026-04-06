{$}
odin = "1.0.0"
transform = "1.0.0"
direction = "odin->xml"
target.format = "xml"
target.rootElement = "data"
description = "Export ODIN to XML verifying null value rendering"

{$source}
format = "odin"

{person}
name = @person.name
age = @person.age
email = @person.email
phone = @person.phone
active = @person.active
