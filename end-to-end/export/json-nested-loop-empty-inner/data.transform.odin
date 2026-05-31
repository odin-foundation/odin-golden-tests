{$}
odin = "1.0.0"
transform = "1.0.0"
direction = "odin->json"
target.format = "json"
description = "An outer item with no inner array yields no rows; the counter resets per outer item"

{rows[]}
:loop vehicles :as veh
:loop .coverages :as cov
:counter idx
vin = "@veh.vin"
code = "@cov.code"
cov_index = "@idx"
