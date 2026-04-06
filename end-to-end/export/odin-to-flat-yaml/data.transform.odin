{$}
odin = "1.0.0"
transform = "1.0.0"
direction = "odin->flat"
target.format = "flat"
target.style = "yaml"
description = "Export ODIN business data to YAML format with indentation"

; YAML supports nesting via indentation
; Arrays use - prefix for items

{$source}
format = "odin"

{company}
name = @company.name
founded = @company.founded
active = @company.active
employeeCount = @company.employeeCount
annualRevenue = @company.annualRevenue

{contact}
email = @contact.email
phone = @contact.phone
website = @contact.website

{address}
street = @address.street
city = @address.city
state = @address.state
zip = @address.zip
country = @address.country

{employees[]}
_loop = "@employees"
id = @.id
name = @.name
department = @.department
salary = @.salary
hireDate = @.hireDate
active = @.active

{products[]}
_loop = "@products"
sku = @.sku
name = @.name
price = @.price
quantity = @.quantity
available = @.available
