{$}
odin = "1.0.0"
transform = "1.0.0"
direction = "odin->csv"
target.format = "csv"
target.includeHeader = true
description = "Export ODIN product catalog to CSV"

; CSV outputs tabular data with header row
; All values become strings, quoted if they contain special characters

{products[]}
_loop = "@products"
sku = @.sku
name = @.name
category = @.category
price = @.price
quantity = @.quantity
inStock = @.inStock
lastUpdated = @.lastUpdated
