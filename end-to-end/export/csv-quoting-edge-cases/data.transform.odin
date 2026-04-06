{$}
odin = "1.0.0"
transform = "1.0.0"
direction = "odin->csv"
target.format = "csv"
target.includeHeader = true
description = "Export ODIN to CSV testing quoting edge cases"

; Tests that CSV output properly handles:
; - Values containing commas (must be quoted)
; - Values containing double quotes (must be escaped as "")
; - Normal values (should NOT be quoted)

{rows[]}
_loop = "@rows"
id = @.id
name = @.name
description = @.description
