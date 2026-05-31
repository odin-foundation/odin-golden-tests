{$}
odin = "1.0.0"
transform = "1.0.0"
direction = "odin->json"
target.format = "json"
description = "Three :loop directives iterate regions x stores x items"

{rows[]}
:loop regions :as r
:loop .stores :as s
:loop .items :as i
region = "@r.name"
store = "@s.id"
sku = "@i.sku"
