{$}
odin = "1.0.0"
transform = "1.0.0"
direction = "odin->csv"
target.format = "csv"
target.header = false
description = "Export ODIN to CSV without header row"

{products[]}
_loop = "@products"
sku = @.sku
name = @.name
price = @.price
