{$}
odin = "1.0.0"
transform = "1.0.0"
direction = "odin->json"
target.format = "json"
target.nulls = "omit"
target.indent = ##2
description = "Export ODIN to JSON with null values omitted"

{person}
name = @person.name
age = @person.age
email = @person.email
phone = @person.phone

{address}
street = @address.street
city = @address.city
state = @address.state
zip = @address.zip
