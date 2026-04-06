{$}
odin = "1.0.0"
transform = "1.0.0"
direction = "odin->json"
target.format = "json"
target.indent = ##2
target.onMissing = "skip"
description = "Export ODIN to JSON with missing fields skipped"

{person}
name = @person.name
age = @person.age
email = @person.email
phone = @person.phone
