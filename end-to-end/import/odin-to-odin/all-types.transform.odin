{$}
odin = "1.0.0"
transform = "1.0.0"
direction = "odin->odin"
target.format = "odin"
target.header = ?true
description = "Identity transform - ODIN passthrough (basic types)"

; Pass through basic values preserving their types

{primitives}
string_simple = @.primitives.string_simple
integer_value = @.primitives.integer_value :type integer
number_value = @.primitives.number_value :type number
currency_value = @.primitives.currency_value :type currency
boolean_value = @.primitives.boolean_value :type boolean
null_value = @.primitives.null_value

{temporal}
date_value = @.temporal.date_value :date
time_value = @.temporal.time_value :time
duration_value = @.temporal.duration_value :duration

{nested}
level1.level2.value = @.nested.level1.level2.value
