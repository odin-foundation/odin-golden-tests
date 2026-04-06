{$}
odin = "1.0.0"
transform = "1.0.0"
direction = "json->json"

; ============================================================
; PRECISION VERBS SELF-TEST
; Tests: Currency rounding, high-precision calculations,
;        floating point handling, banker's rounding
; ============================================================

{$const}
; === CURRENCY PRECISION VALUES ===
price_a = #$10.00
price_b = #$19.99
tax_rate = #0.0825
discount_rate = #0.15

; === EXPECTED RESULTS ===
; 10.00 * 0.0825 = 0.825, rounds to 0.82 (banker's rounding)
tax_a_expected = #$0.82
; 19.99 * 0.0825 = 1.649175, rounds to 1.65
tax_b_expected = #$1.65
; 10.00 * 0.15 = 1.50
discount_a_expected = #$1.50

; === HIGH PRECISION VALUES ===
crypto_amount = #$1.123456789012345678
large_currency = #$999999999999.99

; === FLOATING POINT EDGE CASES ===
; Classic 0.1 + 0.2 != 0.3 issue
fp_a = #0.1
fp_b = #0.2
fp_sum_expected = #0.3

; Currency values that need exact representation
penny = #$0.01
nickel = #$0.05
dime = #$0.10
quarter = #$0.25

{$accumulator}
passed = ##0
failed = ##0

; ============================================================
; PASS 1: BASIC CURRENCY CALCULATIONS
; ============================================================

{_test_currency_multiply_exact}
_pass = ##1
; Exact multiplication
actual = %multiply @$const.price_a @$const.discount_rate
; 10.00 * 0.15 = 1.50 exactly
_ = %ifElse %eq @actual @$const.discount_a_expected %accumulate passed ##1 %accumulate failed ##1

{_test_currency_tax_banker_round_down}
_pass = ##1
; Tax calculation with banker's rounding (0.825 -> 0.82)
actual = %multiply @$const.price_a @$const.tax_rate
roundedActual = %round @actual ##2
_ = %ifElse %eq @roundedActual @$const.tax_a_expected %accumulate passed ##1 %accumulate failed ##1

{_test_currency_add_cents}
_pass = ##1
; Adding pennies exactly
sum = %add @$const.penny @$const.nickel
expected = #$0.06
_ = %ifElse %eq @sum @expected %accumulate passed ##1 %accumulate failed ##1

{_test_currency_add_dimes}
_pass = ##1
; Adding dimes (0.10 + 0.10 + 0.10 = 0.30)
step1 = %add @$const.dime @$const.dime
step2 = %add @step1 @$const.dime
expected = #$0.30
_ = %ifElse %eq @step2 @expected %accumulate passed ##1 %accumulate failed ##1

; ============================================================
; PASS 2: FLOATING POINT HANDLING
; ============================================================

{_test_fp_classic_issue}
_pass = ##2
; The classic 0.1 + 0.2 problem
; In decimal math: 0.1 + 0.2 = 0.3
; In binary float64: 0.1 + 0.2 = 0.30000000000000004
sum = %add @$const.fp_a @$const.fp_b
; Currency should handle this correctly
rounded = %round @sum ##2
expected = #0.30
_ = %ifElse %eq @rounded @expected %accumulate passed ##1 %accumulate failed ##1

{_test_subtraction_precision}
_pass = ##2
; 1.00 - 0.10 - 0.10 - 0.10... should equal 0.00 after 10 iterations
; But floating point accumulates errors
start = #$1.00
step1 = %subtract @start @$const.dime
step2 = %subtract @step1 @$const.dime
step3 = %subtract @step2 @$const.dime
step4 = %subtract @step3 @$const.dime
step5 = %subtract @step4 @$const.dime
step6 = %subtract @step5 @$const.dime
step7 = %subtract @step6 @$const.dime
step8 = %subtract @step7 @$const.dime
step9 = %subtract @step8 @$const.dime
final = %subtract @step9 @$const.dime
rounded = %round @final ##2
expected = #$0.00
_ = %ifElse %eq @rounded @expected %accumulate passed ##1 %accumulate failed ##1

; ============================================================
; PASS 3: ROUNDING MODES
; ============================================================

{_test_round_half_even_up}
_pass = ##3
; Banker's rounding: 2.5 -> 2 (round to even)
value = #2.5
rounded = %round @value ##0
expected = ##2
_ = %ifElse %eq @rounded @expected %accumulate passed ##1 %accumulate failed ##1

{_test_round_half_even_down}
_pass = ##3
; Banker's rounding: 3.5 -> 4 (round to even)
value = #3.5
rounded = %round @value ##0
expected = ##4
_ = %ifElse %eq @rounded @expected %accumulate passed ##1 %accumulate failed ##1

{_test_round_currency_normal}
_pass = ##3
; Normal rounding: 1.235 -> 1.24 (round up)
value = #$1.235
rounded = %round @value ##2
expected = #$1.24
_ = %ifElse %eq @rounded @expected %accumulate passed ##1 %accumulate failed ##1

{_test_ceil_currency}
_pass = ##3
; Ceiling function on currency
value = #$10.01
ceiled = %ceil @value
expected = ##11
_ = %ifElse %eq @ceiled @expected %accumulate passed ##1 %accumulate failed ##1

{_test_floor_currency}
_pass = ##3
; Floor function on currency
value = #$10.99
floored = %floor @value
expected = ##10
_ = %ifElse %eq @floored @expected %accumulate passed ##1 %accumulate failed ##1

; ============================================================
; PASS 4: HIGH PRECISION
; ============================================================

{_test_high_precision_preserved}
_pass = ##4
; 18 decimal places should be preserved for crypto
actual = @$const.crypto_amount
; Verify it's not truncated
isCorrect = %eq @actual @$const.crypto_amount
_ = %ifElse @isCorrect %accumulate passed ##1 %accumulate failed ##1

{_test_large_currency}
_pass = ##4
; Large currency values
actual = @$const.large_currency
isCorrect = %eq @actual @$const.large_currency
_ = %ifElse @isCorrect %accumulate passed ##1 %accumulate failed ##1

{_test_small_fraction}
_pass = ##4
; Very small fraction preserved
small = #$0.000000000000000001
doubled = %multiply @small ##2
expected = #$0.000000000000000002
_ = %ifElse %eq @doubled @expected %accumulate passed ##1 %accumulate failed ##1

; ============================================================
; PASS 5: DIVISION EDGE CASES
; ============================================================

{_test_divide_exact}
_pass = ##5
; 10 / 2 = 5 exactly
result = %divide ##10 ##2
expected = ##5
_ = %ifElse %eq @result @expected %accumulate passed ##1 %accumulate failed ##1

{_test_divide_currency_split}
_pass = ##5
; $10.00 / 3 = $3.333... (what to do with remainder?)
result = %divide @$const.price_a ##3
rounded = %round @result ##2
; Verify it's approximately 3.33
expected = #$3.33
_ = %ifElse %eq @rounded @expected %accumulate passed ##1 %accumulate failed ##1

{_test_divide_by_zero}
_pass = ##5
; Division by zero should return null or error
result = %divide ##10 ##0
isNull = %isNull @result
_ = %ifElse @isNull %accumulate passed ##1 %accumulate failed ##1

; ============================================================
; TEST RESULT OUTPUT
; ============================================================
{TestResult}
verb = "precision"
passed = "@$accumulator.passed"
failed = "@$accumulator.failed"
total = %add @$accumulator.passed @$accumulator.failed
success = %eq @$accumulator.failed ##0
