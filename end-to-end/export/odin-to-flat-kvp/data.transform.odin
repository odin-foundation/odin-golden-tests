{$}
odin = "1.0.0"
transform = "1.0.0"
direction = "odin->flat"
target.format = "flat"
target.style = "kvp"
description = "Export ODIN business data to flat key-value pairs"

; Flat KVP uses dot notation for nesting
; Arrays use bracket notation: employees[0].name
; All values become strings

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
