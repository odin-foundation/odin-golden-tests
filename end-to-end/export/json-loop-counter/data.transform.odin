{$}
odin = "1.0.0"
transform = "1.0.0"
direction = "odin->json"
target.format = "json"
description = ":counter is readable by name and via the accumulator reference"

{rows[]}
:loop items
:counter rownum
sku = "@.sku"
n = "@rownum"
m = "@$accumulator.rownum"
