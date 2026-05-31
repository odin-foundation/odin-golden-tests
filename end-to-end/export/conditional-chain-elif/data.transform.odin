{$}
odin = "1.0.0"
transform = "1.0.0"
direction = "odin->json"
target.format = "json"
description = "if/elif/else conditional chain (mutually exclusive sections)"

{Quote}
driverName = @driver.name

{HighRisk :if %eq @driver.tier "dui"}
band = "high-risk"

{YoungDriver :elif %lt @driver.age ##25}
band = "young-driver"

{Standard :else}
band = "standard"
