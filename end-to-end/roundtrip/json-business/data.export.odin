{$}
odin = "1.0.0"
transform = "1.0.0"
direction = "odin->json"
target.format = "json"
description = "Export ODIN business data to JSON (roundtrip export half)"

{company}
name = @company.name
active = @company.active
employeeCount = @company.employeeCount
rating = @company.rating

{contact}
email = @contact.email
phone = @contact.phone

{employees[]}
_loop = "@employees"
id = @.id
name = @.name
department = @.department
salary = @.salary
active = @.active

{tags[]}
_loop = "@tags"
_ = @
