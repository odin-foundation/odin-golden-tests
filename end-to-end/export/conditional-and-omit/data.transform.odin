{$}
odin = "1.0.0"
transform = "1.0.0"
direction = "odin->json"
target.format = "json"
description = "Compound _if: AND of two comparisons"

{Quote}
driverName = @driver.name

{HighRisk :if "@driver.hasDui = true and @driver.age < 25"}
reason = "DUI under 25"
