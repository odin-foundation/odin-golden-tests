{$}
odin = "1.0.0"
transform = "1.0.0"
direction = "json->json"

; ============================================================
; ACCUMULATOR VERBS SELF-TEST
; Tests: accumulate, set (state management verbs)
; These test the core accumulator/state functionality
; ============================================================

{$const}
; === EXPECTED VALUES ===
expected_sum = ##15
expected_count = ##5
expected_final_set = ##999

{$accumulator}
; Test accumulators
sumTotal = ##0
itemCount = ##0
setValue = ##0
testPassed = ##0
testFailed = ##0

; ============================================================
; PASS 1: ACCUMULATE TESTS - Build up values
; ============================================================

{_accum_item1}
_pass = ##1
; Accumulate 1
_a = %accumulate sumTotal ##1
_b = %accumulate itemCount ##1

{_accum_item2}
_pass = ##1
; Accumulate 2
_a = %accumulate sumTotal ##2
_b = %accumulate itemCount ##1

{_accum_item3}
_pass = ##1
; Accumulate 3
_a = %accumulate sumTotal ##3
_b = %accumulate itemCount ##1

{_accum_item4}
_pass = ##1
; Accumulate 4
_a = %accumulate sumTotal ##4
_b = %accumulate itemCount ##1

{_accum_item5}
_pass = ##1
; Accumulate 5
_a = %accumulate sumTotal ##5
_b = %accumulate itemCount ##1

; ============================================================
; PASS 2: VERIFY ACCUMULATE RESULTS
; ============================================================

{_test_accum_sum}
_pass = ##2
; Sum should be 1+2+3+4+5 = 15
actual = "@$accumulator.sumTotal"
_ = %ifElse %eq @actual @$const.expected_sum %accumulate testPassed ##1 %accumulate testFailed ##1

{_test_accum_count}
_pass = ##2
; Count should be 5
actual = "@$accumulator.itemCount"
_ = %ifElse %eq @actual @$const.expected_count %accumulate testPassed ##1 %accumulate testFailed ##1

; ============================================================
; PASS 3: SET TESTS - Override values
; ============================================================

{_set_value}
_pass = ##3
; Set a specific value (overrides instead of accumulating)
_s = %set setValue ##999

; ============================================================
; PASS 4: VERIFY SET RESULTS
; ============================================================

{_test_set_value}
_pass = ##4
; Value should be exactly 999 (not accumulated)
actual = "@$accumulator.setValue"
_ = %ifElse %eq @actual @$const.expected_final_set %accumulate testPassed ##1 %accumulate testFailed ##1

; ============================================================
; PASS 5: ADDITIONAL ACCUMULATE PATTERNS
; ============================================================

{_accum_additional}
_pass = ##5
; Accumulate some more to existing accumulator
_a = %accumulate sumTotal ##10

{_test_accum_additional}
_pass = ##5
; Sum should now be 15 + 10 = 25
actual = "@$accumulator.sumTotal"
expected = ##25
_ = %ifElse %eq @actual @expected %accumulate testPassed ##1 %accumulate testFailed ##1

; ============================================================
; PASS 6: SET MULTIPLE TIMES
; ============================================================

{_set_multiple1}
_pass = ##6
_s = %set setValue ##100

{_set_multiple2}
_pass = ##6
_s = %set setValue ##200

{_test_set_final}
_pass = ##6
; Value should be 200 (last set wins)
actual = "@$accumulator.setValue"
expected = ##200
_ = %ifElse %eq @actual @expected %accumulate testPassed ##1 %accumulate testFailed ##1

; ============================================================
; TEST RESULT OUTPUT
; ============================================================
{TestResult}
verb = "accumulator"
passed = "@$accumulator.testPassed"
failed = "@$accumulator.testFailed"
total = %add @$accumulator.testPassed @$accumulator.testFailed
success = %eq @$accumulator.testFailed ##0
; Also output the accumulated values for verification
sumTotal = "@$accumulator.sumTotal"
itemCount = "@$accumulator.itemCount"
setValue = "@$accumulator.setValue"
