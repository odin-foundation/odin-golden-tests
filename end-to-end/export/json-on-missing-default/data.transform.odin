{$}
odin = "1.0.0"
transform = "1.0.0"
direction = "odin->json"
target.format = "json"
target.indent = ##2
target.onMissing = "default"
description = "Export ODIN to JSON with missing fields using defaults"

{person}
name = @person.name
age = @person.age
email = @person.email :default "N/A"
phone = @person.phone :default "N/A"
