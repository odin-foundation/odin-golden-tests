{$}
odin = "1.0.0"
transform = "1.0.0"
direction = "odin->json"
target.format = "json"
target.emptyArrays = "omit"
target.indent = ##2
description = "Export ODIN to JSON with empty arrays omitted"

{company}
name = @company.name
active = @company.active

{employees[]}
_loop = "@employees"
id = @.id
name = @.name

{contractors[]}
_loop = "@contractors"
id = @.id
name = @.name
