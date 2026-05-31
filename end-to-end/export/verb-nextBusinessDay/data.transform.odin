{$}
odin = "1.0.0"
transform = "1.0.0"
direction = "json->json"
target.format = "json"
target.indent = ##2

; nextBusinessDay returns the next Mon-Fri date strictly after the input.
{result}
fromWednesday = %nextBusinessDay @.wednesday
fromFriday = %nextBusinessDay @.friday
fromSaturday = %nextBusinessDay @.saturday
fromSunday = %nextBusinessDay @.sunday
