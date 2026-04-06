{$}
odin = "1.0.0"
transform = "1.0.0"
direction = "odin->json"
target.format = "json"
target.indent = ##2

{$source}
format = "odin"

{$const}
company = "ACME Corp"
version = "1.0"

{$accumulator}
runningTotal = ##0
runningTotal._persist = true

{report}
company = @$const.company
version = @$const.version

{items[]}
_loop = "@items"
name = @.name
price = @.price
qty = @.qty
lineTotal = %multiply @.price @.qty
_ = %accumulate runningTotal %multiply @.price @.qty

{summary}
totalValue = "@$accumulator.runningTotal"
