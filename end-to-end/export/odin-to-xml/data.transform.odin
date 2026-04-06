{$}
odin = "1.0.0"
transform = "1.0.0"
direction = "odin->xml"
target.format = "xml"
target.rootElement = "businessData"
description = "Export ODIN business data to XML"

{$source}
format = "odin"

; XML is string-based, so all types become text content
; Booleans become "true"/"false" strings
; Numbers and currency become their string representations

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
id = @.id :attr
name = @.name
department = @.department
salary = @.salary
hireDate = @.hireDate
active = @.active

{products[]}
_loop = "@products"
sku = @.sku :attr
name = @.name
price = @.price
quantity = @.quantity
available = @.available
