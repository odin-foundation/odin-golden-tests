{$}
odin = "1.0.0"
transform = "1.0.0"
direction = "odin->csv"
target.format = "csv"
target.header = true
description = "Export ODIN to CSV verifying currency decimal preservation"

{$source}
format = "odin"

{items[]}
_loop = "@items"
sku = @.sku
price = @.price
total = @.total
balance = @.balance
