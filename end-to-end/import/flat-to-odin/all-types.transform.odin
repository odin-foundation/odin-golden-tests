{$}
odin = "1.0.0"
transform = "1.0.0"
direction = "flat->odin"
target.format = "odin"
description = "Transform flat key-value pairs to ODIN with type annotations"

; ═══════════════════════════════════════════════════════════════════════════════
; PRIMITIVE TYPES
; ═══════════════════════════════════════════════════════════════════════════════

{primitives}
; String types
string_simple = @.primitives.string_simple
string_empty = @.primitives.string_empty
string_unicode = @.primitives.string_unicode
string_long = @.primitives.string_long

; Numeric types
integer_positive = @.primitives.integer_positive :type integer
integer_negative = @.primitives.integer_negative :type integer
integer_zero = @.primitives.integer_zero :type integer
number_simple = @.primitives.number_simple :type number
number_negative = @.primitives.number_negative :type number
currency_simple = @.primitives.currency_simple :type currency
currency_high_precision = @.primitives.currency_high_precision :type currency

; Boolean types
boolean_true = @.primitives.boolean_true :type boolean
boolean_false = @.primitives.boolean_false :type boolean

; Null type
null_value = @.primitives.null_value

; ═══════════════════════════════════════════════════════════════════════════════
; TEMPORAL TYPES
; ═══════════════════════════════════════════════════════════════════════════════

{temporal}
date_simple = @.temporal.date_simple :date
timestamp_utc = @.temporal.timestamp_utc :timestamp
time_simple = @.temporal.time_simple :time
duration_full = @.temporal.duration_full :duration

; ═══════════════════════════════════════════════════════════════════════════════
; ARRAYS
; ═══════════════════════════════════════════════════════════════════════════════

{arrays.strings[]}
_loop = "arrays.strings"
_ = @

{arrays.integers[]}
_loop = "arrays.integers"
_ = @ :type integer

; ═══════════════════════════════════════════════════════════════════════════════
; NESTED OBJECTS
; ═══════════════════════════════════════════════════════════════════════════════

{nested}
level1.level2.value = @.nested.level1.level2.value

{nested.person}
name = @.nested.person.name
age = @.nested.person.age :type integer

{nested.person.address}
city = @.nested.person.address.city
zip = @.nested.person.address.zip

; ═══════════════════════════════════════════════════════════════════════════════
; EMPLOYEES (ARRAY OF OBJECTS)
; ═══════════════════════════════════════════════════════════════════════════════

{employees[]}
_loop = "employees"
id = @.id :type integer
name = @.name
active = @.active :type boolean

; ═══════════════════════════════════════════════════════════════════════════════
; EDGE CASES
; ═══════════════════════════════════════════════════════════════════════════════

{edge_cases}
emoji_string = @.edge_cases.emoji_string
rtl_text = @.edge_cases.rtl_text
path_with_quotes = @.edge_cases.path_with_quotes
equation = @.edge_cases.equation
