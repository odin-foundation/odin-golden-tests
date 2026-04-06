{$}
odin = "1.0.0"
transform = "1.0.0"
direction = "csv->odin"
target.format = "odin"
description = "Transform CSV tabular data to ODIN"

; CSV rows become array elements
; Column headers map directly to field names

{products[]}
_loop = "@"
id = @.id :type integer
name = @.name
price = @.price :type currency
quantity = @.quantity :type integer
inStock = @.inStock :type boolean
rating = @.rating :type number
category = @.category
launchDate = @.launchDate :date
