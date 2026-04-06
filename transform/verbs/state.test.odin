{$}
odin = "1.0.0"
transform = "1.0.0"
direction = "json->json"

; ============================================================
; STATE MANAGEMENT SELF-TEST
; Tests: $const block, $accumulator block, multipass execution
; Verifies constants are accessible and accumulators work
; ============================================================

{$const}
; === STRING CONSTANTS ===
str_tx = "TX"
str_version = "2024.1"
str_name = "TestConst"

; === NUMERIC CONSTANTS ===
num_100 = ##100
num_1_5 = #1.5
num_zero = ##0

; === BOOLEAN CONSTANTS ===
bool_true = ?true
bool_false = ?false

; === COMPOUND CALCULATIONS ===
doubled = ##200
tripled = ##300

{$accumulator}
; Test counters
testPassed = ##0
testFailed = ##0

; Test accumulators for state
counter = ##0
runningTotal = ##0
multiplier = ##1

; ============================================================
; PASS 1: CONST REFERENCE TESTS
; ============================================================

{_test_const_string}
_pass = ##1
actual = "@$const.str_tx"
_ = %ifElse %eq @actual "TX" %accumulate testPassed ##1 %accumulate testFailed ##1

{_test_const_string_version}
_pass = ##1
actual = "@$const.str_version"
_ = %ifElse %eq @actual "2024.1" %accumulate testPassed ##1 %accumulate testFailed ##1

{_test_const_number}
_pass = ##1
actual = "@$const.num_100"
_ = %ifElse %eq @actual ##100 %accumulate testPassed ##1 %accumulate testFailed ##1

{_test_const_float}
_pass = ##1
actual = "@$const.num_1_5"
_ = %ifElse %eq @actual #1.5 %accumulate testPassed ##1 %accumulate testFailed ##1

{_test_const_bool_true}
_pass = ##1
actual = "@$const.bool_true"
_ = %ifElse @actual %accumulate testPassed ##1 %accumulate testFailed ##1

{_test_const_bool_false}
_pass = ##1
actual = "@$const.bool_false"
_ = %ifElse %not @actual %accumulate testPassed ##1 %accumulate testFailed ##1

; ============================================================
; PASS 2: CONST IN VERB OPERATIONS
; ============================================================

{_test_const_in_add}
_pass = ##2
actual = %add @$const.num_100 @$const.num_100
_ = %ifElse %eq @actual @$const.doubled %accumulate testPassed ##1 %accumulate testFailed ##1

{_test_const_in_multiply}
_pass = ##2
actual = %multiply @$const.num_100 ##3
_ = %ifElse %eq @actual @$const.tripled %accumulate testPassed ##1 %accumulate testFailed ##1

{_test_const_in_concat}
_pass = ##2
actual = %concat @$const.str_name "-" @$const.str_version
expected = "TestConst-2024.1"
_ = %ifElse %eq @actual @expected %accumulate testPassed ##1 %accumulate testFailed ##1

; ============================================================
; PASS 3: ACCUMULATOR UPDATE TESTS
; ============================================================

{_accum_counter_1}
_pass = ##3
_a = %accumulate counter ##1

{_accum_counter_2}
_pass = ##3
_a = %accumulate counter ##1

{_accum_counter_3}
_pass = ##3
_a = %accumulate counter ##1

{_accum_total_50}
_pass = ##3
_a = %accumulate runningTotal ##50

{_accum_total_30}
_pass = ##3
_a = %accumulate runningTotal ##30

; ============================================================
; PASS 4: VERIFY ACCUMULATOR VALUES
; ============================================================

{_test_accum_counter}
_pass = ##4
actual = "@$accumulator.counter"
; Counter was incremented 3 times
_ = %ifElse %eq @actual ##3 %accumulate testPassed ##1 %accumulate testFailed ##1

{_test_accum_total}
_pass = ##4
actual = "@$accumulator.runningTotal"
; 50 + 30 = 80
_ = %ifElse %eq @actual ##80 %accumulate testPassed ##1 %accumulate testFailed ##1

; ============================================================
; PASS 5: SET VERB TESTS
; ============================================================

{_set_multiplier}
_pass = ##5
_s = %set multiplier ##5

; ============================================================
; PASS 6: VERIFY SET AND MULTIPASS
; ============================================================

{_test_set_value}
_pass = ##6
actual = "@$accumulator.multiplier"
_ = %ifElse %eq @actual ##5 %accumulate testPassed ##1 %accumulate testFailed ##1

{_test_multipass_counter_persists}
_pass = ##6
; Counter should still be 3 from pass 3
actual = "@$accumulator.counter"
_ = %ifElse %eq @actual ##3 %accumulate testPassed ##1 %accumulate testFailed ##1

{_test_multipass_total_persists}
_pass = ##6
; Total should still be 80 from pass 3
actual = "@$accumulator.runningTotal"
_ = %ifElse %eq @actual ##80 %accumulate testPassed ##1 %accumulate testFailed ##1

; ============================================================
; TEST RESULT OUTPUT
; ============================================================
{TestResult}
verb = "state"
passed = "@$accumulator.testPassed"
failed = "@$accumulator.testFailed"
total = %add @$accumulator.testPassed @$accumulator.testFailed
success = %eq @$accumulator.testFailed ##0
; Output state values for verification
counter = "@$accumulator.counter"
runningTotal = "@$accumulator.runningTotal"
multiplier = "@$accumulator.multiplier"
