{$}
odin = "1.0.0"
transform = "1.0.0"
direction = "xml->odin"
target.format = "odin"
description = "Transform all XML types to ODIN with proper type prefixes"

{$source}
format = "xml"

; ═══════════════════════════════════════════════════════════════════════════════
; PRIMITIVE TYPES
; ═══════════════════════════════════════════════════════════════════════════════

{primitives}
; String types
string_simple = @.root.primitives.string_simple
string_empty = @.root.primitives.string_empty
string_unicode = @.root.primitives.string_unicode
string_special_chars = @.root.primitives.string_special_chars
string_long = @.root.primitives.string_long

; Integer types
integer_positive = @.root.primitives.integer_positive :type integer
integer_negative = @.root.primitives.integer_negative :type integer
integer_zero = @.root.primitives.integer_zero :type integer
integer_large = @.root.primitives.integer_large :type integer
integer_large_negative = @.root.primitives.integer_large_negative :type integer

; Number types
number_simple = @.root.primitives.number_simple :type number
number_negative = @.root.primitives.number_negative :type number
number_zero = @.root.primitives.number_zero :type number
number_scientific = @.root.primitives.number_scientific :type number
number_high_precision = @.root.primitives.number_high_precision :type number

; Currency types
currency_simple = @.root.primitives.currency_simple :type currency
currency_zero = @.root.primitives.currency_zero :type currency
currency_negative = @.root.primitives.currency_negative :type currency
currency_high_precision = @.root.primitives.currency_high_precision :type currency :decimals 18
currency_large = @.root.primitives.currency_large :type currency

; Boolean types
boolean_true = @.root.primitives.boolean_true :type boolean
boolean_false = @.root.primitives.boolean_false :type boolean

; Null type
null_value = @.root.primitives.null_value

; ═══════════════════════════════════════════════════════════════════════════════
; TEMPORAL TYPES
; ═══════════════════════════════════════════════════════════════════════════════

{temporal}
date_simple = @.root.temporal.date_simple :date
date_leap_year = @.root.temporal.date_leap_year :date
date_year_start = @.root.temporal.date_year_start :date
date_year_end = @.root.temporal.date_year_end :date

timestamp_utc = @.root.temporal.timestamp_utc :timestamp
timestamp_offset = @.root.temporal.timestamp_offset :timestamp
timestamp_negative_offset = @.root.temporal.timestamp_negative_offset :timestamp
timestamp_milliseconds = @.root.temporal.timestamp_milliseconds :timestamp

time_simple = @.root.temporal.time_simple :time
time_midnight = @.root.temporal.time_midnight :time
time_end_of_day = @.root.temporal.time_end_of_day :time
time_with_millis = @.root.temporal.time_with_millis :time

duration_years = @.root.temporal.duration_years :duration
duration_months = @.root.temporal.duration_months :duration
duration_days = @.root.temporal.duration_days :duration
duration_complex = @.root.temporal.duration_complex :duration
duration_time = @.root.temporal.duration_time :duration
duration_full = @.root.temporal.duration_full :duration

; ═══════════════════════════════════════════════════════════════════════════════
; SPECIAL TYPES
; ═══════════════════════════════════════════════════════════════════════════════

{special}
reference_simple = @.root.special.reference_target :type reference
reference_nested = @.root.special.reference_nested :type reference
reference_array = @.root.special.reference_array :type reference

binary_simple = @.root.special.binary_simple :type binary
binary_with_algorithm = @.root.special.binary_with_algorithm :type binary

; ═══════════════════════════════════════════════════════════════════════════════
; ARRAYS
; ═══════════════════════════════════════════════════════════════════════════════

{arrays.strings[]}
_loop = "root.arrays.strings.item"
_ = @

{arrays.integers[]}
_loop = "root.arrays.integers.item"
_ = @ :type integer

{arrays.mixed[]}
_loop = "root.arrays.mixed.item"
_ = @

{arrays.empty_array[]}
_loop = "root.arrays.empty_array.item"
_ = @

{arrays.smart_mixed[]}
_loop = "root.arrays.smart_mixed.item"
_ = %tryCoerce @

; ═══════════════════════════════════════════════════════════════════════════════
; TABULAR DATA
; ═══════════════════════════════════════════════════════════════════════════════

{products[]}
_loop = "root.products.product"
id = @.id :type integer
name = @.name
price = @.price :type currency
inStock = @.inStock :type boolean
category = @.category

{employees[]}
_loop = "root.employees.employee"
id = @.id :type integer
name = @.name
hireDate = @.hireDate :date
salary = @.salary :type currency
active = @.active :type boolean

; ═══════════════════════════════════════════════════════════════════════════════
; NESTED OBJECTS
; ═══════════════════════════════════════════════════════════════════════════════

{nested}
level1.level2.level3.value = @.root.nested.level1.level2.level3.value
level1.level2.sibling = @.root.nested.level1.level2.sibling :type integer

{nested.person}
name = @.root.nested.person.name
age = @.root.nested.person.age :type integer

{nested.person.address}
street = @.root.nested.person.address.street
city = @.root.nested.person.address.city
zip = @.root.nested.person.address.zip
country = @.root.nested.person.address.country

{nested.person.contacts[]}
_loop = "root.nested.person.contacts.contact"
type = @.type
value = @.value

; ═══════════════════════════════════════════════════════════════════════════════
; EDGE CASES
; ═══════════════════════════════════════════════════════════════════════════════

{edge_cases}
crypto_amount = @.root.edge_cases.crypto_amount :type currency :decimals 18
pi_extended = @.root.edge_cases.pi_extended :type number
json_in_string = @.root.edge_cases.json_in_string
xml_in_string = @.root.edge_cases.xml_in_string
path_with_spaces = @.root.edge_cases.path_with_spaces
url = @.root.edge_cases.url
max_safe_integer = @.root.edge_cases.max_safe_integer :type integer
min_safe_integer = @.root.edge_cases.min_safe_integer :type integer
emoji_string = @.root.edge_cases.emoji_string
rtl_text = @.root.edge_cases.rtl_text
chinese_text = @.root.edge_cases.chinese_text
mixed_scripts = @.root.edge_cases.mixed_scripts
