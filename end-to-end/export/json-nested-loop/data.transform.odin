{$}
odin = "1.0.0"
transform = "1.0.0"
direction = "odin->json"
target.format = "json"
description = "Two :loop directives iterate vehicles x coverages as a cross-product"

{rows[]}
:loop policy.vehicles :as veh
:loop .coverages :as cov
vehicle_vin = "@veh.vin"
coverage_code = "@cov.code"
coverage_limit = "@cov.limit"
