{primitives}
string_simple = "Hello World"
string_empty = ~
string_unicode = "Hello 世界 🌍 مرحبا"
string_long = "Lorem ipsum dolor sit amet, consectetur adipiscing elit."
integer_positive = ##42
integer_negative = ##-100
integer_zero = ##0
number_simple = #3.14
number_negative = #-273.15
currency_simple = #$99.99
currency_high_precision = #$0.12
boolean_true = ?true
boolean_false = ?false
null_value = ~
{temporal}
date_simple = 2024-12-15
timestamp_utc = 2024-12-15T10:30:00.000Z
time_simple = T14:30:00
duration_full = P1Y2M3DT4H5M6S
{arrays}
{.strings[] : ~}
"first"
"second"
"third"
{.integers[] : ~}
##1
##2
##3
{nested}
level1.level2.value = "deeply nested"
{.person}
name = "Alice Johnson"
age = ##30
{nested.person.address}
city = "Springfield"
zip = ##12345
{employees[] : id, name, active}
##101, "John Smith", ?true
##102, "Jane Doe", ?true
{edge_cases}
emoji_string = "🎉🚀💯🔥"
rtl_text = "שלום עולם"
path_with_quotes = "C:\\\\Program Files\\\\App"
equation = "a=b+c"
