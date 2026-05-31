{$}
odin = "1.0.0"
transform = "1.0.0"
direction = "json->json"
target.format = "json"
target.indent = ##2

; formatDuration accepts a number of seconds or an ISO 8601 duration string.
{result}
fromSeconds = %formatDuration @.seconds
fromSubDaySeconds = %formatDuration @.subDaySeconds
fromIso = %formatDuration @.iso
fromIsoDay = %formatDuration @.isoDay
