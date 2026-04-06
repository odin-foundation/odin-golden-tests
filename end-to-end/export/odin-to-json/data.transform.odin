{$}
odin = "1.0.0"
transform = "1.0.0"
direction = "odin->json"
target.format = "json"
description = "Export ODIN business data to JSON"

; JSON does not support currency type, so currency becomes number
; JSON does not support date type natively, so dates become strings
; All ODIN types map reasonably well to JSON

{company}
name = @company.name
founded = @company.founded
active = @company.active
employeeCount = @company.employeeCount
annualRevenue = @company.annualRevenue
taxRate = @company.taxRate
discountRate = @company.discountRate

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
