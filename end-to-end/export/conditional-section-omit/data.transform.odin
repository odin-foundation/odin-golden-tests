{$}
odin = "1.0.0"
transform = "1.0.0"
direction = "odin->json"
target.format = "json"
description = "Conditionally emit a whole section via header-inline :if"

{Quote}
driverName = @driver.name
hasDui = @driver.hasDui

{DuiDetails :if @driver.hasDui}
convictionDate = @driver.dui.convictionDate
state = @driver.dui.state
bacLevel = @driver.dui.bacLevel
