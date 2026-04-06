{$}
odin = "1.0.0"
transform = "1.0.0"
direction = "odin->csv"
target.format = "csv"
target.delimiter = "|"
target.header = true
description = "Export ODIN to CSV with pipe delimiter"

{products[]}
_loop = "@products"
sku = @.sku
name = @.name
price = @.price
quantity = @.quantity
