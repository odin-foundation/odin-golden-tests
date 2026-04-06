{$}
odin = "1.0.0"
transform = "1.0.0"
direction = "csv->odin"
target.format = "odin"
description = "Import CSV product catalog to ODIN (roundtrip import half)"

{$source}
format = "csv"

{products[]}
_loop = "@"
sku = @.sku
name = @.name
category = @.category
price = @.price :type currency
quantity = @.quantity :type integer
inStock = @.inStock :type boolean
