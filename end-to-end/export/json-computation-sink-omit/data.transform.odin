{$}
odin = "1.0.0"
transform = "1.0.0"
direction = "odin->json"
target.format = "json"
description = "A _-prefixed looping computation section is omitted from output"

{$accumulator}
total = ##0

{_sumItems[]}
:loop items
_ = "%accumulate total @.amount"

{Summary}
total = "@$accumulator.total"
