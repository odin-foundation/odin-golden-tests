{$}
odin = "1.0.0"
transform = "1.0.0"
direction = "odin->json"
target.format = "json"
description = "Validation modifiers warn but still emit when onValidation = warn"
target.onValidation = "warn"

{Record}
status = "@record.status :enum A,P,C"
year = "@record.year :range 1900..2100"
email = "@record.email :validate \"^[^@]+@[^@]+$\""
