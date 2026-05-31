{$}
odin = "1.0.0"
transform = "1.0.0"
direction = "odin->json"
target.format = "json"
description = "Field :if path = value emits only when the comparison holds"

{Quote}
discount = "@policy.discount :if @policy.tier = gold"
surcharge = "@policy.surcharge :if @policy.tier = bronze"
