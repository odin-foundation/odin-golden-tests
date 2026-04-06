{$}
odin = "1.0.0"
transform = "1.0.0"
direction = "json->json"

; ============================================================
; COERCION VERBS SELF-TEST
; Tests: coerceString, coerceNumber, coerceInteger,
;        coerceBoolean, coerceDate, coerceTimestamp
; ============================================================

{$const}
; === STRING COERCION VALUES ===
num_42 = ##42
num_3_14 = #3.14
bool_true = ?true
bool_false = ?false
str_hello = "hello"

coerce_str_num_expected = "42"
coerce_str_float_expected = "3.14"
coerce_str_true_expected = "true"
coerce_str_false_expected = "false"

; === NUMBER COERCION VALUES ===
str_num = "42"
str_float = "3.14"
str_neg = "-100"

coerce_num_str_expected = ##42
coerce_num_float_expected = #3.14
coerce_num_neg_expected = ##-100
coerce_num_bool_true_expected = ##1
coerce_num_bool_false_expected = ##0

; === INTEGER COERCION VALUES ===
float_val = #3.7
float_neg = #-3.7

coerce_int_float_expected = ##3
coerce_int_neg_expected = ##-3
coerce_int_str_expected = ##42

; === BOOLEAN COERCION VALUES ===
str_true = "true"
str_false = "false"
str_yes = "yes"
str_no = "no"
num_1 = ##1
num_0 = ##0

coerce_bool_true_expected = ?true
coerce_bool_false_expected = ?false

; === DATE COERCION VALUES ===
date_str = "2024-06-15"
date_slash = "06/15/2024"
timestamp_str = "2024-06-15T14:30:00Z"

; === TIMESTAMP VALUES ===
unix_ts = ##1718452200

{$accumulator}
passed = ##0
failed = ##0

; ============================================================
; PASS 1: COERCE STRING TESTS
; ============================================================

{_test_coerceString_num}
_pass = ##1
actual = %coerceString @$const.num_42
_ = %ifElse %eq @actual @$const.coerce_str_num_expected %accumulate passed ##1 %accumulate failed ##1

{_test_coerceString_float}
_pass = ##1
actual = %coerceString @$const.num_3_14
_ = %ifElse %eq @actual @$const.coerce_str_float_expected %accumulate passed ##1 %accumulate failed ##1

{_test_coerceString_true}
_pass = ##1
actual = %coerceString @$const.bool_true
_ = %ifElse %eq @actual @$const.coerce_str_true_expected %accumulate passed ##1 %accumulate failed ##1

{_test_coerceString_false}
_pass = ##1
actual = %coerceString @$const.bool_false
_ = %ifElse %eq @actual @$const.coerce_str_false_expected %accumulate passed ##1 %accumulate failed ##1

{_test_coerceString_string}
_pass = ##1
; coercing string to string should return same string
actual = %coerceString @$const.str_hello
_ = %ifElse %eq @actual @$const.str_hello %accumulate passed ##1 %accumulate failed ##1

; ============================================================
; PASS 2: COERCE NUMBER TESTS
; ============================================================

{_test_coerceNumber_str}
_pass = ##2
actual = %coerceNumber @$const.str_num
_ = %ifElse %eq @actual @$const.coerce_num_str_expected %accumulate passed ##1 %accumulate failed ##1

{_test_coerceNumber_float_str}
_pass = ##2
actual = %coerceNumber @$const.str_float
_ = %ifElse %eq @actual @$const.coerce_num_float_expected %accumulate passed ##1 %accumulate failed ##1

{_test_coerceNumber_neg_str}
_pass = ##2
actual = %coerceNumber @$const.str_neg
_ = %ifElse %eq @actual @$const.coerce_num_neg_expected %accumulate passed ##1 %accumulate failed ##1

{_test_coerceNumber_bool_true}
_pass = ##2
actual = %coerceNumber @$const.bool_true
_ = %ifElse %eq @actual @$const.coerce_num_bool_true_expected %accumulate passed ##1 %accumulate failed ##1

{_test_coerceNumber_bool_false}
_pass = ##2
actual = %coerceNumber @$const.bool_false
_ = %ifElse %eq @actual @$const.coerce_num_bool_false_expected %accumulate passed ##1 %accumulate failed ##1

{_test_coerceNumber_number}
_pass = ##2
; coercing number to number should return same number
actual = %coerceNumber @$const.num_42
_ = %ifElse %eq @actual @$const.num_42 %accumulate passed ##1 %accumulate failed ##1

; ============================================================
; PASS 3: COERCE INTEGER TESTS
; ============================================================

{_test_coerceInteger_float}
_pass = ##3
actual = %coerceInteger @$const.float_val
_ = %ifElse %eq @actual @$const.coerce_int_float_expected %accumulate passed ##1 %accumulate failed ##1

{_test_coerceInteger_neg_float}
_pass = ##3
actual = %coerceInteger @$const.float_neg
_ = %ifElse %eq @actual @$const.coerce_int_neg_expected %accumulate passed ##1 %accumulate failed ##1

{_test_coerceInteger_str}
_pass = ##3
actual = %coerceInteger @$const.str_num
_ = %ifElse %eq @actual @$const.coerce_int_str_expected %accumulate passed ##1 %accumulate failed ##1

{_test_coerceInteger_integer}
_pass = ##3
; coercing integer to integer should return same integer
actual = %coerceInteger @$const.num_42
_ = %ifElse %eq @actual @$const.num_42 %accumulate passed ##1 %accumulate failed ##1

; ============================================================
; PASS 4: COERCE BOOLEAN TESTS
; ============================================================

{_test_coerceBoolean_str_true}
_pass = ##4
actual = %coerceBoolean @$const.str_true
_ = %ifElse %eq @actual @$const.coerce_bool_true_expected %accumulate passed ##1 %accumulate failed ##1

{_test_coerceBoolean_str_false}
_pass = ##4
actual = %coerceBoolean @$const.str_false
_ = %ifElse %eq @actual @$const.coerce_bool_false_expected %accumulate passed ##1 %accumulate failed ##1

{_test_coerceBoolean_str_yes}
_pass = ##4
actual = %coerceBoolean @$const.str_yes
_ = %ifElse %eq @actual @$const.coerce_bool_true_expected %accumulate passed ##1 %accumulate failed ##1

{_test_coerceBoolean_str_no}
_pass = ##4
actual = %coerceBoolean @$const.str_no
_ = %ifElse %eq @actual @$const.coerce_bool_false_expected %accumulate passed ##1 %accumulate failed ##1

{_test_coerceBoolean_num_1}
_pass = ##4
actual = %coerceBoolean @$const.num_1
_ = %ifElse %eq @actual @$const.coerce_bool_true_expected %accumulate passed ##1 %accumulate failed ##1

{_test_coerceBoolean_num_0}
_pass = ##4
actual = %coerceBoolean @$const.num_0
_ = %ifElse %eq @actual @$const.coerce_bool_false_expected %accumulate passed ##1 %accumulate failed ##1

{_test_coerceBoolean_bool}
_pass = ##4
; coercing boolean to boolean should return same boolean
actual = %coerceBoolean @$const.bool_true
_ = %ifElse %eq @actual @$const.bool_true %accumulate passed ##1 %accumulate failed ##1

; ============================================================
; PASS 5: COERCE DATE TESTS
; ============================================================

{_test_coerceDate_iso}
_pass = ##5
actual = %coerceDate @$const.date_str
; The result should be a date type - verify it's not null
isNull = %isNull @actual
_ = %ifElse %not @isNull %accumulate passed ##1 %accumulate failed ##1

{_test_coerceDate_timestamp}
_pass = ##5
actual = %coerceDate @$const.timestamp_str
; The result should be a date type - verify it's not null
isNull = %isNull @actual
_ = %ifElse %not @isNull %accumulate passed ##1 %accumulate failed ##1

; ============================================================
; PASS 6: COERCE TIMESTAMP TESTS
; ============================================================

{_test_coerceTimestamp_string}
_pass = ##6
actual = %coerceTimestamp @$const.timestamp_str
; The result should be a timestamp type - verify it's not null
isNull = %isNull @actual
_ = %ifElse %not @isNull %accumulate passed ##1 %accumulate failed ##1

{_test_coerceTimestamp_date}
_pass = ##6
actual = %coerceTimestamp @$const.date_str
; The result should be a timestamp type - verify it's not null
isNull = %isNull @actual
_ = %ifElse %not @isNull %accumulate passed ##1 %accumulate failed ##1

; ============================================================
; PASS 7: TRY COERCE TESTS
; ============================================================

{_test_tryCoerce_integer}
_pass = ##7
actual = %tryCoerce @$const.str_num
_ = %ifElse %eq @actual @$const.coerce_num_str_expected %accumulate passed ##1 %accumulate failed ##1

{_test_tryCoerce_float}
_pass = ##7
actual = %tryCoerce @$const.str_float
_ = %ifElse %eq @actual @$const.coerce_num_float_expected %accumulate passed ##1 %accumulate failed ##1

{_test_tryCoerce_bool_true}
_pass = ##7
actual = %tryCoerce @$const.str_true
_ = %ifElse %eq @actual @$const.coerce_bool_true_expected %accumulate passed ##1 %accumulate failed ##1

{_test_tryCoerce_bool_false}
_pass = ##7
actual = %tryCoerce @$const.str_false
_ = %ifElse %eq @actual @$const.coerce_bool_false_expected %accumulate passed ##1 %accumulate failed ##1

{_test_tryCoerce_string_passthrough}
_pass = ##7
; A regular string should pass through unchanged
actual = %tryCoerce @$const.str_hello
_ = %ifElse %eq @actual @$const.str_hello %accumulate passed ##1 %accumulate failed ##1

{_test_tryCoerce_date}
_pass = ##7
actual = %tryCoerce @$const.date_str
; The result should be a date type - verify it's not null
isNull = %isNull @actual
_ = %ifElse %not @isNull %accumulate passed ##1 %accumulate failed ##1

{_test_tryCoerce_already_typed}
_pass = ##7
; Already typed values should pass through unchanged
actual = %tryCoerce @$const.num_42
_ = %ifElse %eq @actual @$const.num_42 %accumulate passed ##1 %accumulate failed ##1

; ============================================================
; TEST RESULT OUTPUT
; ============================================================
{TestResult}
verb = "coercion"
passed = "@$accumulator.passed"
failed = "@$accumulator.failed"
total = %add @$accumulator.passed @$accumulator.failed
success = %eq @$accumulator.failed ##0
