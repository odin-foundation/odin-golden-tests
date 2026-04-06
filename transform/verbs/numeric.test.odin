{$}
odin = "1.0.0"
transform = "1.0.0"
direction = "json->json"

; ============================================================
; NUMERIC VERBS SELF-TEST
; Tests: formatNumber, formatInteger, formatCurrency, floor, ceil,
;        mod, switch, sign, trunc, minOf, maxOf, formatPercent,
;        isFinite, isNaN, parseInt
; Note: add, subtract, multiply, divide, round, abs, negate
;       tested in insurance.test.odin
; ============================================================

{$const}
; === FORMAT NUMBER VALUES ===
num_pi = #3.14159265
format_2dp = "3.14"
format_4dp = "3.1416"
format_0dp = "3"

; === FORMAT INTEGER VALUES ===
num_1234 = ##1234
formatInt_expected = "1,234"

; === FORMAT CURRENCY VALUES ===
currency_val = #1234.56
formatCurrency_expected = "1234.56"

; === FLOOR/CEIL VALUES ===
num_3_7 = #3.7
num_neg_3_7 = #-3.7
floor_expected = ##3
floor_neg_expected = ##-4
ceil_expected = ##4
ceil_neg_expected = ##-3

; === MOD VALUES ===
num_10 = ##10
num_3 = ##3
mod_expected = ##1

; === SWITCH VALUES ===
switch_val = "B"
switch_expected = "Beta"
switch_default = "Unknown"

; === SIGN VALUES ===
num_pos = ##42
num_neg = ##-42
num_zero = ##0
sign_pos_expected = ##1
sign_neg_expected = ##-1
sign_zero_expected = ##0

; === TRUNC VALUES ===
trunc_pos_expected = ##3
trunc_neg_expected = ##-3

; === MINOF/MAXOF VALUES ===
num_1 = ##1
num_5 = ##5
minOf_expected = ##1
maxOf_expected = ##10

; === FORMAT PERCENT VALUES ===
pct_val = #0.1234
formatPct_expected = "12.34%"

; === ISFINITE/ISNAN VALUES ===
num_normal = ##100
isFinite_expected = ?true

; === PARSEINT VALUES ===
hex_str = "FF"
hex_radix = ##16
parseInt_expected = ##255
dec_str = "42"
parseInt_dec_expected = ##42

{$accumulator}
passed = ##0
failed = ##0

; ============================================================
; PASS 1: FORMAT NUMBER TESTS
; ============================================================

{_test_formatNumber_2dp}
_pass = ##1
actual = %formatNumber @$const.num_pi ##2
_ = %ifElse %eq @actual @$const.format_2dp %accumulate passed ##1 %accumulate failed ##1

{_test_formatNumber_4dp}
_pass = ##1
actual = %formatNumber @$const.num_pi ##4
_ = %ifElse %eq @actual @$const.format_4dp %accumulate passed ##1 %accumulate failed ##1

{_test_formatNumber_0dp}
_pass = ##1
actual = %formatNumber @$const.num_pi ##0
_ = %ifElse %eq @actual @$const.format_0dp %accumulate passed ##1 %accumulate failed ##1

{_test_formatInteger}
_pass = ##1
actual = %formatInteger @$const.num_1234
_ = %ifElse %eq @actual @$const.formatInt_expected %accumulate passed ##1 %accumulate failed ##1

{_test_formatCurrency}
_pass = ##1
actual = %formatCurrency @$const.currency_val
_ = %ifElse %eq @actual @$const.formatCurrency_expected %accumulate passed ##1 %accumulate failed ##1

; ============================================================
; PASS 2: FLOOR AND CEIL TESTS
; ============================================================

{_test_floor_pos}
_pass = ##2
actual = %floor @$const.num_3_7
_ = %ifElse %eq @actual @$const.floor_expected %accumulate passed ##1 %accumulate failed ##1

{_test_floor_neg}
_pass = ##2
actual = %floor @$const.num_neg_3_7
_ = %ifElse %eq @actual @$const.floor_neg_expected %accumulate passed ##1 %accumulate failed ##1

{_test_ceil_pos}
_pass = ##2
actual = %ceil @$const.num_3_7
_ = %ifElse %eq @actual @$const.ceil_expected %accumulate passed ##1 %accumulate failed ##1

{_test_ceil_neg}
_pass = ##2
actual = %ceil @$const.num_neg_3_7
_ = %ifElse %eq @actual @$const.ceil_neg_expected %accumulate passed ##1 %accumulate failed ##1

; ============================================================
; PASS 3: MOD AND SWITCH TESTS
; ============================================================

{_test_mod}
_pass = ##3
actual = %mod @$const.num_10 @$const.num_3
_ = %ifElse %eq @actual @$const.mod_expected %accumulate passed ##1 %accumulate failed ##1

{_test_mod_zero}
_pass = ##3
; 9 mod 3 = 0
actual = %mod ##9 @$const.num_3
_ = %ifElse %eq @actual @$const.num_zero %accumulate passed ##1 %accumulate failed ##1

{_test_switch_match}
_pass = ##3
actual = %switch @$const.switch_val "A" "Alpha" "B" "Beta" "C" "Charlie" "Unknown"
_ = %ifElse %eq @actual @$const.switch_expected %accumulate passed ##1 %accumulate failed ##1

{_test_switch_default}
_pass = ##3
actual = %switch "Z" "A" "Alpha" "B" "Beta" "Unknown"
_ = %ifElse %eq @actual @$const.switch_default %accumulate passed ##1 %accumulate failed ##1

; ============================================================
; PASS 4: SIGN AND TRUNC TESTS
; ============================================================

{_test_sign_pos}
_pass = ##4
actual = %sign @$const.num_pos
_ = %ifElse %eq @actual @$const.sign_pos_expected %accumulate passed ##1 %accumulate failed ##1

{_test_sign_neg}
_pass = ##4
actual = %sign @$const.num_neg
_ = %ifElse %eq @actual @$const.sign_neg_expected %accumulate passed ##1 %accumulate failed ##1

{_test_sign_zero}
_pass = ##4
actual = %sign @$const.num_zero
_ = %ifElse %eq @actual @$const.sign_zero_expected %accumulate passed ##1 %accumulate failed ##1

{_test_trunc_pos}
_pass = ##4
actual = %trunc @$const.num_3_7
_ = %ifElse %eq @actual @$const.trunc_pos_expected %accumulate passed ##1 %accumulate failed ##1

{_test_trunc_neg}
_pass = ##4
; trunc toward zero: -3.7 -> -3
actual = %trunc @$const.num_neg_3_7
_ = %ifElse %eq @actual @$const.trunc_neg_expected %accumulate passed ##1 %accumulate failed ##1

; ============================================================
; PASS 5: MINOF, MAXOF TESTS
; ============================================================

{_test_minOf}
_pass = ##5
actual = %minOf @$const.num_5 @$const.num_1 @$const.num_10
_ = %ifElse %eq @actual @$const.minOf_expected %accumulate passed ##1 %accumulate failed ##1

{_test_maxOf}
_pass = ##5
actual = %maxOf @$const.num_5 @$const.num_1 @$const.num_10
_ = %ifElse %eq @actual @$const.maxOf_expected %accumulate passed ##1 %accumulate failed ##1

{_test_minOf_single}
_pass = ##5
actual = %minOf @$const.num_5
_ = %ifElse %eq @actual @$const.num_5 %accumulate passed ##1 %accumulate failed ##1

{_test_maxOf_single}
_pass = ##5
actual = %maxOf @$const.num_5
_ = %ifElse %eq @actual @$const.num_5 %accumulate passed ##1 %accumulate failed ##1

; ============================================================
; PASS 6: FORMAT PERCENT, ISFINITE TESTS
; ============================================================

{_test_formatPercent}
_pass = ##6
actual = %formatPercent @$const.pct_val ##2
_ = %ifElse %eq @actual @$const.formatPct_expected %accumulate passed ##1 %accumulate failed ##1

{_test_isFinite_true}
_pass = ##6
actual = %isFinite @$const.num_normal
_ = %ifElse %eq @actual @$const.isFinite_expected %accumulate passed ##1 %accumulate failed ##1

; ============================================================
; PASS 7: PARSEINT TESTS
; ============================================================

{_test_parseInt_hex}
_pass = ##7
actual = %parseInt @$const.hex_str @$const.hex_radix
_ = %ifElse %eq @actual @$const.parseInt_expected %accumulate passed ##1 %accumulate failed ##1

{_test_parseInt_dec}
_pass = ##7
actual = %parseInt @$const.dec_str ##10
_ = %ifElse %eq @actual @$const.parseInt_dec_expected %accumulate passed ##1 %accumulate failed ##1

{_test_parseInt_binary}
_pass = ##7
; "1010" in binary = 10 in decimal
actual = %parseInt "1010" ##2
_ = %ifElse %eq @actual @$const.num_10 %accumulate passed ##1 %accumulate failed ##1

; ============================================================
; PASS 8: RANDOM TESTS
; ============================================================

{_test_random_basic}
_pass = ##8
; random generates a number between 0 and 1 by default
actual = %random
inRange = %between @actual ##0 ##1
_ = %ifElse @inRange %accumulate passed ##1 %accumulate failed ##1

{_test_random_range}
_pass = ##8
; random with min/max should be in that range
actual = %random ##1 ##100
inRange = %between @actual ##1 ##100
_ = %ifElse @inRange %accumulate passed ##1 %accumulate failed ##1

{_test_random_unique}
_pass = ##8
; Two random calls should produce different values (with very high probability)
r1 = %random
r2 = %random
diff = %ne @r1 @r2
_ = %ifElse @diff %accumulate passed ##1 %accumulate failed ##1

; ============================================================
; PASS 9: ISNAN, ISFINITE TESTS
; ============================================================

{_test_isNaN_num}
_pass = ##9
; Normal number is not NaN
actual = %isNaN ##42
_ = %ifElse %not @actual %accumulate passed ##1 %accumulate failed ##1

{_test_isNaN_zero}
_pass = ##9
; Zero is not NaN
actual = %isNaN ##0
_ = %ifElse %not @actual %accumulate passed ##1 %accumulate failed ##1

; ============================================================
; PASS 10: LOCALE-AWARE FORMATTING TESTS
; ============================================================

{_test_formatLocaleNumber_basic}
_pass = ##10
; formatLocaleNumber should return a string
actual = %formatLocaleNumber ##1234.56
isStr = %isString @actual
_ = %ifElse @isStr %accumulate passed ##1 %accumulate failed ##1

{_test_formatLocaleNumber_en_US}
_pass = ##10
; US locale uses comma for thousands, period for decimal
actual = %formatLocaleNumber ##1234.56 "en-US"
expected = "1,234.56"
_ = %ifElse %eq @actual @expected %accumulate passed ##1 %accumulate failed ##1

{_test_formatLocaleNumber_integer}
_pass = ##10
; Integer formatting with locale
actual = %formatLocaleNumber ##1000000 "en-US"
expected = "1,000,000"
_ = %ifElse %eq @actual @expected %accumulate passed ##1 %accumulate failed ##1

; ============================================================
; PASS 11: SAFEDIVIDE TESTS
; ============================================================

{_test_safeDivide_normal}
_pass = ##11
; Normal division: 10 / 2 = 5
actual = %safeDivide ##10 ##2 ##0
_ = %ifElse %eq @actual ##5 %accumulate passed ##1 %accumulate failed ##1

{_test_safeDivide_zero_denom}
_pass = ##11
; Division by zero returns default
actual = %safeDivide ##10 ##0 ##-1
_ = %ifElse %eq @actual ##-1 %accumulate passed ##1 %accumulate failed ##1

{_test_safeDivide_decimal}
_pass = ##11
; Decimal result: 10 / 4 = 2.5
actual = %safeDivide ##10 ##4 ##0
expected = #2.5
diff = %subtract @actual @expected
absDiff = %abs @diff
isClose = %lt @absDiff #0.001
_ = %ifElse @isClose %accumulate passed ##1 %accumulate failed ##1

{_test_safeDivide_string_default}
_pass = ##11
; Can return string default for zero
actual = %safeDivide ##10 ##0 "N/A"
_ = %ifElse %eq @actual "N/A" %accumulate passed ##1 %accumulate failed ##1

; ============================================================
; TEST RESULT OUTPUT
; ============================================================
{TestResult}
verb = "numeric"
passed = "@$accumulator.passed"
failed = "@$accumulator.failed"
total = %add @$accumulator.passed @$accumulator.failed
success = %eq @$accumulator.failed ##0
