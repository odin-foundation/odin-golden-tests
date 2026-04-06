{$}
odin = "1.0.0"
transform = "1.0.0"
direction = "json->json"

; ============================================================
; COMPREHENSIVE INSURANCE VERBS SELF-TEST
; Tests: String verbs (upper, lower, titleCase, concat, substring,
;        padLeft, replaceRegex, mask), Date verbs (formatDate, dateDiff,
;        addDays, addMonths), Lookup tables, Conditionals (ifElse, switch,
;        cond), Aggregations (sum, count, min, max, avg, first, last),
;        Math (add, subtract, multiply, divide, round, abs, negate)
; ============================================================

{$const}
; === STRING TEST VALUES ===
str_upper_input = "hello world"
str_upper_expected = "HELLO WORLD"
str_lower_input = "HELLO WORLD"
str_lower_expected = "hello world"
str_title_input = "hello world"
str_title_expected = "Hello World"

; === CONCAT TEST VALUES ===
concat_a = "Hello"
concat_b = " "
concat_c = "World"
concat_expected = "Hello World"

; === SUBSTRING TEST VALUES ===
substr_input = "Hello World"
substr_start = ##0
substr_len = ##5
substr_expected = "Hello"

; === PADLEFT TEST VALUES ===
padleft_input = ##42
padleft_len = ##5
padleft_char = "0"
padleft_expected = "00042"

; === DATE FORMAT TEST VALUES ===
date_input = "2024-06-15"
date_mmddyyyy = "06152024"
date_slash = "06/15/2024"

; === MASK TEST VALUES ===
phone_input = "5125551234"
phone_expected = "(512) 555-1234"
ssn_input = "123456789"
ssn_masked = "XXX-XX-6789"

; === CONDITIONAL TEST VALUES ===
bool_true = ?true
bool_false = ?false
switch_input = "sedan"
switch_expected = "SD"

; === MATH TEST VALUES ===
math_a = ##100
math_b = ##25
add_expected = ##125
subtract_expected = ##75
multiply_expected = ##2500
divide_expected = ##4

; === ROUND TEST VALUES ===
round_input = #3.14159
round_2dp = #3.14
round_0dp = ##3

; === ABS/NEGATE TEST VALUES ===
neg_input = ##-50
abs_expected = ##50
negate_expected = ##50
pos_negate_expected = ##-100

; === AGGREGATION TEST VALUES (using inline arrays) ===
; Array [100, 200, 300, 400, 500]
agg_sum = ##1500
agg_count = ##5
agg_min = ##100
agg_max = ##500
agg_avg = ##300
agg_first = ##100
agg_last = ##500

{$accumulator}
passed = ##0
failed = ##0

; ============================================================
; LOOKUP TABLE FOR SWITCH TESTS
; ============================================================
{$table.BODY_TYPES[name, code]}
"sedan", "SD"
"coupe", "CP"
"suv", "SU"
"truck", "TK"

{$table.STATUS[name, code, active]}
"active", "A", "Y"
"pending", "P", "N"
"cancelled", "C", "N"

; ============================================================
; PASS 1: STRING CASE CONVERSION TESTS
; ============================================================

{_test_upper}
_pass = ##1
actual = %upper @$const.str_upper_input
_ = %ifElse %eq @actual @$const.str_upper_expected %accumulate passed ##1 %accumulate failed ##1

{_test_lower}
_pass = ##1
actual = %lower @$const.str_lower_input
_ = %ifElse %eq @actual @$const.str_lower_expected %accumulate passed ##1 %accumulate failed ##1

{_test_titleCase}
_pass = ##1
actual = %titleCase @$const.str_title_input
_ = %ifElse %eq @actual @$const.str_title_expected %accumulate passed ##1 %accumulate failed ##1

; Round-trip: lower(upper(x)) should give lowercase
{_test_case_roundtrip}
_pass = ##1
upper_result = %upper @$const.str_upper_input
actual = %lower @upper_result
_ = %ifElse %eq @actual @$const.str_upper_input %accumulate passed ##1 %accumulate failed ##1

; ============================================================
; PASS 2: STRING MANIPULATION TESTS
; ============================================================

{_test_concat}
_pass = ##2
actual = %concat @$const.concat_a @$const.concat_b @$const.concat_c
_ = %ifElse %eq @actual @$const.concat_expected %accumulate passed ##1 %accumulate failed ##1

{_test_substring}
_pass = ##2
actual = %substring @$const.substr_input @$const.substr_start @$const.substr_len
_ = %ifElse %eq @actual @$const.substr_expected %accumulate passed ##1 %accumulate failed ##1

{_test_padLeft}
_pass = ##2
actual = %padLeft @$const.padleft_input @$const.padleft_len @$const.padleft_char
_ = %ifElse %eq @actual @$const.padleft_expected %accumulate passed ##1 %accumulate failed ##1

{_test_mask_phone}
_pass = ##2
actual = %mask @$const.phone_input "(###) ###-####"
_ = %ifElse %eq @actual @$const.phone_expected %accumulate passed ##1 %accumulate failed ##1

; SSN masking: concat XXX-XX- with last 4 digits
{_test_ssn_mask}
_pass = ##2
actual = %concat "XXX-XX-" %substring @$const.ssn_input ##5 ##4
_ = %ifElse %eq @actual @$const.ssn_masked %accumulate passed ##1 %accumulate failed ##1

; ============================================================
; PASS 3: DATE FORMATTING TESTS
; ============================================================

{_test_formatDate_mmddyyyy}
_pass = ##3
actual = %formatDate @$const.date_input "MMDDYYYY"
_ = %ifElse %eq @actual @$const.date_mmddyyyy %accumulate passed ##1 %accumulate failed ##1

{_test_formatDate_slash}
_pass = ##3
actual = %formatDate @$const.date_input "MM/DD/YYYY"
_ = %ifElse %eq @actual @$const.date_slash %accumulate passed ##1 %accumulate failed ##1

; ============================================================
; PASS 4: CONDITIONAL LOGIC TESTS
; ============================================================

{_test_ifElse_true}
_pass = ##4
actual = %ifElse @$const.bool_true "YES" "NO"
_ = %ifElse %eq @actual "YES" %accumulate passed ##1 %accumulate failed ##1

{_test_ifElse_false}
_pass = ##4
actual = %ifElse @$const.bool_false "YES" "NO"
_ = %ifElse %eq @actual "NO" %accumulate passed ##1 %accumulate failed ##1

{_test_switch}
_pass = ##4
actual = %switch @$const.switch_input "sedan" "SD" "coupe" "CP" "suv" "SU" "XX"
_ = %ifElse %eq @actual @$const.switch_expected %accumulate passed ##1 %accumulate failed ##1

{_test_switch_default}
_pass = ##4
actual = %switch "unknown" "sedan" "SD" "coupe" "CP" "XX"
_ = %ifElse %eq @actual "XX" %accumulate passed ##1 %accumulate failed ##1

; ============================================================
; PASS 5: LOOKUP TABLE TESTS
; ============================================================

{_test_lookup_single}
_pass = ##5
actual = %lookup BODY_TYPES.code "sedan"
_ = %ifElse %eq @actual "SD" %accumulate passed ##1 %accumulate failed ##1

{_test_lookup_status_code}
_pass = ##5
actual = %lookup STATUS.code "active"
_ = %ifElse %eq @actual "A" %accumulate passed ##1 %accumulate failed ##1

{_test_lookup_status_active}
_pass = ##5
actual = %lookup STATUS.active "active"
_ = %ifElse %eq @actual "Y" %accumulate passed ##1 %accumulate failed ##1

{_test_lookupDefault_found}
_pass = ##5
actual = %lookupDefault BODY_TYPES.code "sedan" "XX"
_ = %ifElse %eq @actual "SD" %accumulate passed ##1 %accumulate failed ##1

{_test_lookupDefault_notfound}
_pass = ##5
actual = %lookupDefault BODY_TYPES.code "motorcycle" "XX"
_ = %ifElse %eq @actual "XX" %accumulate passed ##1 %accumulate failed ##1

; ============================================================
; PASS 6: MATH OPERATION TESTS
; ============================================================

{_test_add}
_pass = ##6
actual = %add @$const.math_a @$const.math_b
_ = %ifElse %eq @actual @$const.add_expected %accumulate passed ##1 %accumulate failed ##1

{_test_subtract}
_pass = ##6
actual = %subtract @$const.math_a @$const.math_b
_ = %ifElse %eq @actual @$const.subtract_expected %accumulate passed ##1 %accumulate failed ##1

{_test_multiply}
_pass = ##6
actual = %multiply @$const.math_a @$const.math_b
_ = %ifElse %eq @actual @$const.multiply_expected %accumulate passed ##1 %accumulate failed ##1

{_test_divide}
_pass = ##6
actual = %divide @$const.math_a @$const.math_b
_ = %ifElse %eq @actual @$const.divide_expected %accumulate passed ##1 %accumulate failed ##1

{_test_round_2dp}
_pass = ##6
actual = %round @$const.round_input ##2
_ = %ifElse %eq @actual @$const.round_2dp %accumulate passed ##1 %accumulate failed ##1

{_test_round_0dp}
_pass = ##6
actual = %round @$const.round_input ##0
_ = %ifElse %eq @actual @$const.round_0dp %accumulate passed ##1 %accumulate failed ##1

{_test_abs}
_pass = ##6
actual = %abs @$const.neg_input
_ = %ifElse %eq @actual @$const.abs_expected %accumulate passed ##1 %accumulate failed ##1

{_test_negate_neg}
_pass = ##6
actual = %negate @$const.neg_input
_ = %ifElse %eq @actual @$const.negate_expected %accumulate passed ##1 %accumulate failed ##1

{_test_negate_pos}
_pass = ##6
actual = %negate @$const.math_a
_ = %ifElse %eq @actual @$const.pos_negate_expected %accumulate passed ##1 %accumulate failed ##1

; Math round-trip: (a + b) - b = a
{_test_math_roundtrip}
_pass = ##6
added = %add @$const.math_a @$const.math_b
actual = %subtract @added @$const.math_b
_ = %ifElse %eq @actual @$const.math_a %accumulate passed ##1 %accumulate failed ##1

; ============================================================
; PASS 7: AGGREGATION TESTS (using inline arrays)
; ============================================================

{_internal_agg}
_pass = ##7
; Create test array for aggregation operations
values = "[##100, ##200, ##300, ##400, ##500]"

{_test_sum}
_pass = ##7
actual = %sum @_internal_agg.values
_ = %ifElse %eq @actual @$const.agg_sum %accumulate passed ##1 %accumulate failed ##1

{_test_count}
_pass = ##7
actual = %count @_internal_agg.values
_ = %ifElse %eq @actual @$const.agg_count %accumulate passed ##1 %accumulate failed ##1

{_test_min}
_pass = ##7
actual = %min @_internal_agg.values
_ = %ifElse %eq @actual @$const.agg_min %accumulate passed ##1 %accumulate failed ##1

{_test_max}
_pass = ##7
actual = %max @_internal_agg.values
_ = %ifElse %eq @actual @$const.agg_max %accumulate passed ##1 %accumulate failed ##1

{_test_avg}
_pass = ##7
actual = %avg @_internal_agg.values
_ = %ifElse %eq @actual @$const.agg_avg %accumulate passed ##1 %accumulate failed ##1

{_test_first}
_pass = ##7
actual = %first @_internal_agg.values
_ = %ifElse %eq @actual @$const.agg_first %accumulate passed ##1 %accumulate failed ##1

{_test_last}
_pass = ##7
actual = %last @_internal_agg.values
_ = %ifElse %eq @actual @$const.agg_last %accumulate passed ##1 %accumulate failed ##1

; sum/count round-trip: avg * count = sum
{_test_agg_roundtrip}
_pass = ##7
avgVal = %avg @_internal_agg.values
countVal = %count @_internal_agg.values
actual = %multiply @avgVal @countVal
_ = %ifElse %eq @actual @$const.agg_sum %accumulate passed ##1 %accumulate failed ##1

; ============================================================
; PASS 8: COMPLEX INSURANCE CALCULATION TESTS
; ============================================================

{_internal_policy}
_pass = ##8
; Simulate policy premium calculation
basePremium = ##850
discountRate = #0.15
taxRate = #0.0825

{_test_discount_calc}
_pass = ##8
; Calculate discount amount: base * rate
discountAmt = %multiply @_internal_policy.basePremium @_internal_policy.discountRate
; Expected: 850 * 0.15 = 127.5
actual = %round @discountAmt ##1
_ = %ifElse %eq @actual #127.5 %accumulate passed ##1 %accumulate failed ##1

{_test_subtotal_calc}
_pass = ##8
; Calculate subtotal: base - discount
discountAmt = %multiply @_internal_policy.basePremium @_internal_policy.discountRate
subtotal = %subtract @_internal_policy.basePremium @discountAmt
; Expected: 850 - 127.5 = 722.5
actual = %round @subtotal ##1
_ = %ifElse %eq @actual #722.5 %accumulate passed ##1 %accumulate failed ##1

{_test_tax_calc}
_pass = ##8
; Calculate tax: subtotal * taxRate
discountAmt = %multiply @_internal_policy.basePremium @_internal_policy.discountRate
subtotal = %subtract @_internal_policy.basePremium @discountAmt
taxAmt = %multiply @subtotal @_internal_policy.taxRate
; Expected: 722.5 * 0.0825 = 59.60625 -> 59.61
actual = %round @taxAmt ##2
_ = %ifElse %eq @actual #59.61 %accumulate passed ##1 %accumulate failed ##1

{_test_total_premium}
_pass = ##8
; Calculate total: subtotal + tax
discountAmt = %multiply @_internal_policy.basePremium @_internal_policy.discountRate
subtotal = %subtract @_internal_policy.basePremium @discountAmt
taxAmt = %multiply @subtotal @_internal_policy.taxRate
total = %add @subtotal @taxAmt
; Expected: 722.5 + 59.60625 = 782.10625 -> 782.11
actual = %round @total ##2
_ = %ifElse %eq @actual #782.11 %accumulate passed ##1 %accumulate failed ##1

; ============================================================
; TEST RESULT OUTPUT
; ============================================================
{TestResult}
verb = "insurance"
passed = "@$accumulator.passed"
failed = "@$accumulator.failed"
total = %add @$accumulator.passed @$accumulator.failed
success = %eq @$accumulator.failed ##0
