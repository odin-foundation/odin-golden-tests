{$}
odin = "1.0.0"
transform = "1.0.0"
direction = "odin->json"
target.format = "json"
target.indent = ##2
enforceConfidential = "redact"

{person}
name = @person.name
ssn = @person.ssn :confidential
email = @person.email
phone = @person.phone :confidential
age = @person.age
