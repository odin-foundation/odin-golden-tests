{$}
odin = "1.0.0"
transform = "1.0.0"
direction = "json->json"

; ============================================================
; LOGIC VERBS SELF-TEST
; Tests: not, xor, ne, lt, lte, gt, gte, between,
;        isNull, isString, isNumber, isBoolean, isArray,
;        isObject, isDate, typeOf, cond
; Note: and, or, eq are tested in and.test.odin and used as
;       infrastructure for all self-tests
; ============================================================

{$const}
; === BOOLEAN VALUES ===
bool_true = ?true
bool_false = ?false

; === NOT TEST VALUES ===
not_true_expected = ?false
not_false_expected = ?true

; === XOR TEST VALUES ===
xor_tt_expected = ?false
xor_tf_expected = ?true
xor_ft_expected = ?true
xor_ff_expected = ?false

; === COMPARISON VALUES ===
num_1 = ##1
num_2 = ##2
num_5 = ##5
num_10 = ##10

; === NE TEST VALUES ===
ne_diff_expected = ?true
ne_same_expected = ?false

; === LT/LTE TEST VALUES ===
lt_less_expected = ?true
lt_equal_expected = ?false
lt_greater_expected = ?false
lte_less_expected = ?true
lte_equal_expected = ?true
lte_greater_expected = ?false

; === GT/GTE TEST VALUES ===
gt_greater_expected = ?true
gt_equal_expected = ?false
gt_less_expected = ?false
gte_greater_expected = ?true
gte_equal_expected = ?true
gte_less_expected = ?false

; === BETWEEN TEST VALUES ===
between_in_expected = ?true
between_below_expected = ?false
between_above_expected = ?false
between_at_min_expected = ?true
between_at_max_expected = ?true

; === TYPE CHECK VALUES ===
null_val = ~
str_val = "hello"
num_val = ##42
bool_val = ?true
date_val = "2024-01-15"

; === TYPE CHECK EXPECTED ===
isNull_null_expected = ?true
isNull_str_expected = ?false
isString_str_expected = ?true
isString_num_expected = ?false
isNumber_num_expected = ?true
isNumber_str_expected = ?false
isBoolean_bool_expected = ?true
isBoolean_str_expected = ?false

; === TYPEOF EXPECTED ===
typeof_null_expected = "null"
typeof_string_expected = "string"
typeof_integer_expected = "integer"
typeof_boolean_expected = "boolean"

; === COND TEST VALUES ===
cond_match_val = ##2
cond_default_val = ##99

{$accumulator}
passed = ##0
failed = ##0

; ============================================================
; PASS 1: NOT AND XOR TESTS
; ============================================================

{_test_not_true}
_pass = ##1
actual = %not @$const.bool_true
_ = %ifElse %eq @actual @$const.not_true_expected %accumulate passed ##1 %accumulate failed ##1

{_test_not_false}
_pass = ##1
actual = %not @$const.bool_false
_ = %ifElse %eq @actual @$const.not_false_expected %accumulate passed ##1 %accumulate failed ##1

{_test_xor_tt}
_pass = ##1
actual = %xor @$const.bool_true @$const.bool_true
_ = %ifElse %eq @actual @$const.xor_tt_expected %accumulate passed ##1 %accumulate failed ##1

{_test_xor_tf}
_pass = ##1
actual = %xor @$const.bool_true @$const.bool_false
_ = %ifElse %eq @actual @$const.xor_tf_expected %accumulate passed ##1 %accumulate failed ##1

{_test_xor_ft}
_pass = ##1
actual = %xor @$const.bool_false @$const.bool_true
_ = %ifElse %eq @actual @$const.xor_ft_expected %accumulate passed ##1 %accumulate failed ##1

{_test_xor_ff}
_pass = ##1
actual = %xor @$const.bool_false @$const.bool_false
_ = %ifElse %eq @actual @$const.xor_ff_expected %accumulate passed ##1 %accumulate failed ##1

; ============================================================
; PASS 2: NE, LT, LTE TESTS
; ============================================================

{_test_ne_diff}
_pass = ##2
actual = %ne @$const.num_1 @$const.num_2
_ = %ifElse %eq @actual @$const.ne_diff_expected %accumulate passed ##1 %accumulate failed ##1

{_test_ne_same}
_pass = ##2
actual = %ne @$const.num_1 @$const.num_1
_ = %ifElse %eq @actual @$const.ne_same_expected %accumulate passed ##1 %accumulate failed ##1

{_test_lt_less}
_pass = ##2
actual = %lt @$const.num_1 @$const.num_2
_ = %ifElse %eq @actual @$const.lt_less_expected %accumulate passed ##1 %accumulate failed ##1

{_test_lt_equal}
_pass = ##2
actual = %lt @$const.num_1 @$const.num_1
_ = %ifElse %eq @actual @$const.lt_equal_expected %accumulate passed ##1 %accumulate failed ##1

{_test_lt_greater}
_pass = ##2
actual = %lt @$const.num_2 @$const.num_1
_ = %ifElse %eq @actual @$const.lt_greater_expected %accumulate passed ##1 %accumulate failed ##1

{_test_lte_less}
_pass = ##2
actual = %lte @$const.num_1 @$const.num_2
_ = %ifElse %eq @actual @$const.lte_less_expected %accumulate passed ##1 %accumulate failed ##1

{_test_lte_equal}
_pass = ##2
actual = %lte @$const.num_1 @$const.num_1
_ = %ifElse %eq @actual @$const.lte_equal_expected %accumulate passed ##1 %accumulate failed ##1

{_test_lte_greater}
_pass = ##2
actual = %lte @$const.num_2 @$const.num_1
_ = %ifElse %eq @actual @$const.lte_greater_expected %accumulate passed ##1 %accumulate failed ##1

; ============================================================
; PASS 3: GT, GTE TESTS
; ============================================================

{_test_gt_greater}
_pass = ##3
actual = %gt @$const.num_2 @$const.num_1
_ = %ifElse %eq @actual @$const.gt_greater_expected %accumulate passed ##1 %accumulate failed ##1

{_test_gt_equal}
_pass = ##3
actual = %gt @$const.num_1 @$const.num_1
_ = %ifElse %eq @actual @$const.gt_equal_expected %accumulate passed ##1 %accumulate failed ##1

{_test_gt_less}
_pass = ##3
actual = %gt @$const.num_1 @$const.num_2
_ = %ifElse %eq @actual @$const.gt_less_expected %accumulate passed ##1 %accumulate failed ##1

{_test_gte_greater}
_pass = ##3
actual = %gte @$const.num_2 @$const.num_1
_ = %ifElse %eq @actual @$const.gte_greater_expected %accumulate passed ##1 %accumulate failed ##1

{_test_gte_equal}
_pass = ##3
actual = %gte @$const.num_1 @$const.num_1
_ = %ifElse %eq @actual @$const.gte_equal_expected %accumulate passed ##1 %accumulate failed ##1

{_test_gte_less}
_pass = ##3
actual = %gte @$const.num_1 @$const.num_2
_ = %ifElse %eq @actual @$const.gte_less_expected %accumulate passed ##1 %accumulate failed ##1

; ============================================================
; PASS 4: BETWEEN TESTS
; ============================================================

{_test_between_in}
_pass = ##4
actual = %between @$const.num_5 @$const.num_1 @$const.num_10
_ = %ifElse %eq @actual @$const.between_in_expected %accumulate passed ##1 %accumulate failed ##1

{_test_between_below}
_pass = ##4
; 1 is not between 5 and 10
actual = %between @$const.num_1 @$const.num_5 @$const.num_10
_ = %ifElse %eq @actual @$const.between_below_expected %accumulate passed ##1 %accumulate failed ##1

{_test_between_at_min}
_pass = ##4
; 1 is between 1 and 10 (inclusive)
actual = %between @$const.num_1 @$const.num_1 @$const.num_10
_ = %ifElse %eq @actual @$const.between_at_min_expected %accumulate passed ##1 %accumulate failed ##1

{_test_between_at_max}
_pass = ##4
; 10 is between 1 and 10 (inclusive)
actual = %between @$const.num_10 @$const.num_1 @$const.num_10
_ = %ifElse %eq @actual @$const.between_at_max_expected %accumulate passed ##1 %accumulate failed ##1

; ============================================================
; PASS 5: TYPE CHECK TESTS - isNull, isString, isNumber, isBoolean
; ============================================================

{_test_isNull_null}
_pass = ##5
actual = %isNull @$const.null_val
_ = %ifElse %eq @actual @$const.isNull_null_expected %accumulate passed ##1 %accumulate failed ##1

{_test_isNull_str}
_pass = ##5
actual = %isNull @$const.str_val
_ = %ifElse %eq @actual @$const.isNull_str_expected %accumulate passed ##1 %accumulate failed ##1

{_test_isString_str}
_pass = ##5
actual = %isString @$const.str_val
_ = %ifElse %eq @actual @$const.isString_str_expected %accumulate passed ##1 %accumulate failed ##1

{_test_isString_num}
_pass = ##5
actual = %isString @$const.num_val
_ = %ifElse %eq @actual @$const.isString_num_expected %accumulate passed ##1 %accumulate failed ##1

{_test_isNumber_num}
_pass = ##5
actual = %isNumber @$const.num_val
_ = %ifElse %eq @actual @$const.isNumber_num_expected %accumulate passed ##1 %accumulate failed ##1

{_test_isNumber_str}
_pass = ##5
actual = %isNumber @$const.str_val
_ = %ifElse %eq @actual @$const.isNumber_str_expected %accumulate passed ##1 %accumulate failed ##1

{_test_isBoolean_bool}
_pass = ##5
actual = %isBoolean @$const.bool_val
_ = %ifElse %eq @actual @$const.isBoolean_bool_expected %accumulate passed ##1 %accumulate failed ##1

{_test_isBoolean_str}
_pass = ##5
actual = %isBoolean @$const.str_val
_ = %ifElse %eq @actual @$const.isBoolean_str_expected %accumulate passed ##1 %accumulate failed ##1

; ============================================================
; PASS 6: TYPEOF TESTS
; ============================================================

{_test_typeof_null}
_pass = ##6
actual = %typeOf @$const.null_val
_ = %ifElse %eq @actual @$const.typeof_null_expected %accumulate passed ##1 %accumulate failed ##1

{_test_typeof_string}
_pass = ##6
actual = %typeOf @$const.str_val
_ = %ifElse %eq @actual @$const.typeof_string_expected %accumulate passed ##1 %accumulate failed ##1

{_test_typeof_integer}
_pass = ##6
actual = %typeOf @$const.num_val
_ = %ifElse %eq @actual @$const.typeof_integer_expected %accumulate passed ##1 %accumulate failed ##1

{_test_typeof_boolean}
_pass = ##6
actual = %typeOf @$const.bool_val
_ = %ifElse %eq @actual @$const.typeof_boolean_expected %accumulate passed ##1 %accumulate failed ##1

; ============================================================
; PASS 7: OR AND ADDITIONAL TYPE CHECK TESTS
; ============================================================

{_test_or_tt}
_pass = ##7
actual = %or @$const.bool_true @$const.bool_true
_ = %ifElse @actual %accumulate passed ##1 %accumulate failed ##1

{_test_or_tf}
_pass = ##7
actual = %or @$const.bool_true @$const.bool_false
_ = %ifElse @actual %accumulate passed ##1 %accumulate failed ##1

{_test_or_ft}
_pass = ##7
actual = %or @$const.bool_false @$const.bool_true
_ = %ifElse @actual %accumulate passed ##1 %accumulate failed ##1

{_test_or_ff}
_pass = ##7
actual = %or @$const.bool_false @$const.bool_false
_ = %ifElse %not @actual %accumulate passed ##1 %accumulate failed ##1

{_test_isArray_array}
_pass = ##7
arr = "[##1, ##2, ##3]"
actual = %isArray @arr
_ = %ifElse @actual %accumulate passed ##1 %accumulate failed ##1

{_test_isArray_string}
_pass = ##7
actual = %isArray @$const.str_val
_ = %ifElse %not @actual %accumulate passed ##1 %accumulate failed ##1

{_test_isObject_object}
_pass = ##7
obj = "{\"name\": \"test\"}"
actual = %isObject @obj
_ = %ifElse @actual %accumulate passed ##1 %accumulate failed ##1

{_test_isObject_string}
_pass = ##7
actual = %isObject @$const.str_val
_ = %ifElse %not @actual %accumulate passed ##1 %accumulate failed ##1

{_test_isDate_date}
_pass = ##7
; Parse a date first, then check if it's a date type
dateVal = %coerceDate @$const.date_val
actual = %isDate @dateVal
_ = %ifElse @actual %accumulate passed ##1 %accumulate failed ##1

{_test_isDate_string}
_pass = ##7
; A raw string is not a date type
actual = %isDate @$const.str_val
_ = %ifElse %not @actual %accumulate passed ##1 %accumulate failed ##1

; ============================================================
; PASS 8: COND TESTS
; ============================================================

{_test_cond_first_match}
_pass = ##8
; cond with first condition true: cond (1==1) "first" (2==2) "second" "default"
actual = %cond %eq @$const.num_1 @$const.num_1 "first" %eq @$const.num_2 @$const.num_2 "second" "default"
_ = %ifElse %eq @actual "first" %accumulate passed ##1 %accumulate failed ##1

{_test_cond_second_match}
_pass = ##8
; cond with second condition true: cond (1==2) "first" (2==2) "second" "default"
actual = %cond %eq @$const.num_1 @$const.num_2 "first" %eq @$const.num_2 @$const.num_2 "second" "default"
_ = %ifElse %eq @actual "second" %accumulate passed ##1 %accumulate failed ##1

{_test_cond_default}
_pass = ##8
; cond with no match: cond (1==2) "first" (1==5) "second" "default"
actual = %cond %eq @$const.num_1 @$const.num_2 "first" %eq @$const.num_1 @$const.num_5 "second" "default"
_ = %ifElse %eq @actual "default" %accumulate passed ##1 %accumulate failed ##1

; ============================================================
; TEST RESULT OUTPUT
; ============================================================
{TestResult}
verb = "logic"
passed = "@$accumulator.passed"
failed = "@$accumulator.failed"
total = %add @$accumulator.passed @$accumulator.failed
success = %eq @$accumulator.failed ##0
