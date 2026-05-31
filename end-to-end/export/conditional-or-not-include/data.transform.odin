{$}
odin = "1.0.0"
transform = "1.0.0"
direction = "odin->json"
target.format = "json"
description = "Compound _if: OR with a NOT factor"

{Quote}
driverName = @driver.name

{ManualReview :if "@driver.state = 'CA' or not @driver.verified"}
reason = "needs review"
