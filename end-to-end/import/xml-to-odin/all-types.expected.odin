{primitives}
string_simple = "Hello World"
string_empty = ""
string_unicode = "Hello 世界 🌍 مرحبا"
string_special_chars = "Line1\nLine2\tTabbed\"Quoted\""
string_long = "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua."
integer_positive = ##42
integer_negative = ##-100
integer_zero = ##0
integer_large = ##9007199254740991
integer_large_negative = ##-9007199254740991
number_simple = #3.14
number_negative = #-273.15
number_zero = #0.0
number_scientific = #6.022e23
number_high_precision = #3.141592653589793238
currency_simple = #$99.99
currency_zero = #$0.00
currency_negative = #$-50.00
currency_high_precision = #$0.123456789012345678
currency_large = #$1000000.00
boolean_true = ?true
boolean_false = ?false
null_value = ~
{temporal}
date_simple = 2024-12-15
date_leap_year = 2024-02-29
date_year_start = 2024-01-01
date_year_end = 2024-12-31
timestamp_utc = 2024-12-15T10:30:00.000Z
timestamp_offset = 2024-12-15T05:00:00.000Z
timestamp_negative_offset = 2024-12-15T18:30:00.000Z
timestamp_milliseconds = 2024-12-15T10:30:00.123Z
time_simple = T14:30:00
time_midnight = T00:00:00
time_end_of_day = T23:59:59
time_with_millis = T14:30:00.500
duration_years = P1Y
duration_months = P6M
duration_days = P30D
duration_complex = P1Y2M3D
duration_time = PT2H30M
duration_full = P1Y2M3DT4H5M6S
{special}
reference_simple = @primitives.string_simple
reference_nested = @temporal.timestamp_utc
reference_array = @arrays.strings[0]
binary_simple = ^SGVsbG8gV29ybGQ=
binary_with_algorithm = ^sha256:2cf24dba5fb0a30e26e83b2ac5b9e29e1b161e5c1fa7425e73043362938b9824
{arrays}
{.strings[] : ~}
"first"
"second"
"third"
{.integers[] : ~}
##1
##2
##3
{.mixed[] : ~}
"string value"
"42"
"99.99"
"true"
~
{.empty_array[] : ~}
~
{.smart_mixed[] : ~}
"hello world"
##42
#3.14
?true
?false
2024-06-15
~
{products[] : id, name, price, inStock, category}
~, ~, ~, ~, ~
~, ~, ~, ~, ~
~, ~, ~, ~, ~
{employees[] : id, name, hireDate, salary, active}
~, ~, ~, ~, ~
~, ~, ~, ~, ~
~, ~, ~, ~, ~
{nested}
{.level1}
{nested.level1.level2}
level3.value = "deeply nested"
sibling = ##42
{.person}
name = "Alice Johnson"
age = ##30
{.contacts[] : type, value}
~, ~
~, ~
{nested.person.address}
street = "123 Main St"
city = "Springfield"
zip = "12345"
country = "USA"
{edge_cases}
crypto_amount = #$0.000000000000000001
pi_extended = #3.14159265358979323846264338327950288
json_in_string = "{\"key\": \"value\", \"array\": [1,2,3]}"
xml_in_string = "<root><child attr=\"val\">text</child></root>"
path_with_spaces = "C:\\Program Files\\My App\\config.json"
url = "https://example.com/path?query=value&other=123"
max_safe_integer = ##9007199254740991
min_safe_integer = ##-9007199254740991
emoji_string = "🎉🚀💯🔥"
rtl_text = "שלום עולם"
chinese_text = "你好世界"
mixed_scripts = "Hello こんにちは Привет"
