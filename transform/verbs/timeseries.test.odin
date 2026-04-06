{$}
odin = "1.0.0"
transform = "1.0.0"
direction = "json->json"

; ============================================================
; TIME-SERIES / CUMULATIVE VERBS SELF-TEST
; Tests: cumsum, cumprod, shift, diff, pctChange, zscore
; ============================================================

{$const}
; === ZSCORE VALUES ===
zscore_at_mean = ##80
zscore_above = ##85

{$accumulator}
passed = ##0
failed = ##0

; ============================================================
; PASS 1: CUMSUM TESTS (arrays defined inline)
; ============================================================

{_arrays1}
_pass = ##1
nums = "[##1, ##2, ##3, ##4]"

{_test_cumsum_basic}
_pass = ##1
actual = %cumsum @_arrays1.nums
isArr = %isArray @actual
_ = %ifElse @isArr %accumulate passed ##1 %accumulate failed ##1

{_test_cumsum_count}
_pass = ##1
actual = %cumsum @_arrays1.nums
cnt = %count @actual
_ = %ifElse %eq @cnt ##4 %accumulate passed ##1 %accumulate failed ##1

{_test_cumsum_first}
_pass = ##1
actual = %cumsum @_arrays1.nums
first = %at @actual ##0
_ = %ifElse %eq @first ##1 %accumulate passed ##1 %accumulate failed ##1

{_test_cumsum_last}
_pass = ##1
actual = %cumsum @_arrays1.nums
last = %at @actual ##3
_ = %ifElse %eq @last ##10 %accumulate passed ##1 %accumulate failed ##1

; ============================================================
; PASS 2: CUMPROD TESTS
; ============================================================

{_arrays2}
_pass = ##2
nums = "[##1, ##2, ##3, ##4]"

{_test_cumprod_basic}
_pass = ##2
actual = %cumprod @_arrays2.nums
isArr = %isArray @actual
_ = %ifElse @isArr %accumulate passed ##1 %accumulate failed ##1

{_test_cumprod_first}
_pass = ##2
actual = %cumprod @_arrays2.nums
first = %at @actual ##0
_ = %ifElse %eq @first ##1 %accumulate passed ##1 %accumulate failed ##1

{_test_cumprod_second}
_pass = ##2
actual = %cumprod @_arrays2.nums
second = %at @actual ##1
_ = %ifElse %eq @second ##2 %accumulate passed ##1 %accumulate failed ##1

{_test_cumprod_last}
_pass = ##2
actual = %cumprod @_arrays2.nums
last = %at @actual ##3
_ = %ifElse %eq @last ##24 %accumulate passed ##1 %accumulate failed ##1

; ============================================================
; PASS 3: DIFF TESTS
; ============================================================

{_arrays3}
_pass = ##3
diff_input = "[##10, ##15, ##12, ##18]"

{_test_diff_basic}
_pass = ##3
actual = %diff @_arrays3.diff_input
isArr = %isArray @actual
_ = %ifElse @isArr %accumulate passed ##1 %accumulate failed ##1

{_test_diff_count}
_pass = ##3
actual = %diff @_arrays3.diff_input
cnt = %count @actual
_ = %ifElse %eq @cnt ##4 %accumulate passed ##1 %accumulate failed ##1

{_test_diff_first_is_null}
_pass = ##3
; First element should be null (no previous value)
actual = %diff @_arrays3.diff_input
first = %at @actual ##0
firstIsNull = %isNull @first
_ = %ifElse @firstIsNull %accumulate passed ##1 %accumulate failed ##1

{_test_diff_second}
_pass = ##3
; 15 - 10 = 5
actual = %diff @_arrays3.diff_input
second = %at @actual ##1
_ = %ifElse %eq @second ##5 %accumulate passed ##1 %accumulate failed ##1

{_test_diff_third}
_pass = ##3
; 12 - 15 = -3
actual = %diff @_arrays3.diff_input
third = %at @actual ##2
_ = %ifElse %eq @third ##-3 %accumulate passed ##1 %accumulate failed ##1

; ============================================================
; PASS 4: PCT CHANGE TESTS
; ============================================================

{_arrays4}
_pass = ##4
pctChange_input = "[##100, ##110, ##99]"

{_test_pctChange_basic}
_pass = ##4
actual = %pctChange @_arrays4.pctChange_input
isArr = %isArray @actual
_ = %ifElse @isArr %accumulate passed ##1 %accumulate failed ##1

{_test_pctChange_first_null}
_pass = ##4
actual = %pctChange @_arrays4.pctChange_input
first = %at @actual ##0
isNull = %isNull @first
_ = %ifElse @isNull %accumulate passed ##1 %accumulate failed ##1

{_test_pctChange_second}
_pass = ##4
; (110 - 100) / 100 = 0.1
actual = %pctChange @_arrays4.pctChange_input
second = %at @actual ##1
diff = %subtract @second #0.1
absDiff = %abs @diff
isClose = %lt @absDiff #0.0001
_ = %ifElse @isClose %accumulate passed ##1 %accumulate failed ##1

; ============================================================
; PASS 5: SHIFT TESTS
; ============================================================

{_arrays5}
_pass = ##5
shift_input = "[##10, ##20, ##30, ##40]"

{_test_shift_basic}
_pass = ##5
; Default shift by 1 forward
actual = %shift @_arrays5.shift_input
isArr = %isArray @actual
_ = %ifElse @isArr %accumulate passed ##1 %accumulate failed ##1

{_test_shift_first_null}
_pass = ##5
; First element should be null after forward shift
actual = %shift @_arrays5.shift_input ##1
first = %at @actual ##0
isNull = %isNull @first
_ = %ifElse @isNull %accumulate passed ##1 %accumulate failed ##1

{_test_shift_second_val}
_pass = ##5
; Second element should be first original value (10)
actual = %shift @_arrays5.shift_input ##1
second = %at @actual ##1
_ = %ifElse %eq @second ##10 %accumulate passed ##1 %accumulate failed ##1

; ============================================================
; PASS 6: ZSCORE TESTS
; ============================================================

{_arrays6}
_pass = ##6
zscore_data = "[##70, ##75, ##80, ##85, ##90]"

{_test_zscore_at_mean}
_pass = ##6
; Z-score at mean should be 0
actual = %zscore @$const.zscore_at_mean @_arrays6.zscore_data
; Result is 0 or very close to 0
diff = %abs @actual
isZero = %lt @diff #0.0001
_ = %ifElse @isZero %accumulate passed ##1 %accumulate failed ##1

{_test_zscore_above_mean}
_pass = ##6
; Z-score above mean should be positive
actual = %zscore @$const.zscore_above @_arrays6.zscore_data
isPos = %gt @actual ##0
_ = %ifElse @isPos %accumulate passed ##1 %accumulate failed ##1

{_test_zscore_below_mean}
_pass = ##6
; Z-score below mean should be negative
actual = %zscore ##75 @_arrays6.zscore_data
isNeg = %lt @actual ##0
_ = %ifElse @isNeg %accumulate passed ##1 %accumulate failed ##1

; ============================================================
; TEST RESULT OUTPUT
; ============================================================
{TestResult}
verb = "timeseries"
passed = "@$accumulator.passed"
failed = "@$accumulator.failed"
total = %add @$accumulator.passed @$accumulator.failed
success = %eq @$accumulator.failed ##0
