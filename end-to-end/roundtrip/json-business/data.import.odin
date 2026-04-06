{$}
odin = "1.0.0"
transform = "1.0.0"
direction = "json->odin"
target.format = "odin"
description = "Import JSON business data to ODIN (roundtrip import half)"

{$source}
format = "json"

{company}
name = @.company.name
active = @.company.active :type boolean
employeeCount = @.company.employeeCount :type integer
rating = @.company.rating :type number

{contact}
email = @.contact.email
phone = @.contact.phone

{employees[]}
_loop = "employees"
id = @.id :type integer
name = @.name
department = @.department
salary = @.salary :type integer
active = @.active :type boolean

{tags[]}
_loop = "tags"
_ = @
