{$}
odin = "1.0.0"
transform = "1.0.0"
direction = "json->json"

; ============================================================
; INTERPOLATION SELF-TEST
; Tests: String interpolation with ${} syntax using constants
; Note: Tests using @. source paths are in JSON suite (need input)
; ============================================================

{$const}
; === INTERPOLATION SOURCE VALUES ===
name = "World"
first = "John"
last = "Doe"
greeting = "Hello"
version = "1.0"
city = "Austin"
state = "TX"

; === EXPECTED RESULTS ===
expected_hello = "Hello, World!"
expected_full_name = "John Doe"
expected_location = "Austin, TX"
expected_version = "Version: 1.0"

{$accumulator}
passed = ##0
failed = ##0

; ============================================================
; PASS 1: SIMPLE INTERPOLATION TESTS
; ============================================================

{_test_interp_simple}
_pass = ##1
actual = "${@$const.greeting}, ${@$const.name}!"
_ = %ifElse %eq @actual @$const.expected_hello %accumulate passed ##1 %accumulate failed ##1

{_test_interp_name}
_pass = ##1
actual = "${@$const.first} ${@$const.last}"
_ = %ifElse %eq @actual @$const.expected_full_name %accumulate passed ##1 %accumulate failed ##1

; ============================================================
; PASS 2: MULTIPLE INTERPOLATION TESTS
; ============================================================

{_test_interp_location}
_pass = ##2
actual = "${@$const.city}, ${@$const.state}"
_ = %ifElse %eq @actual @$const.expected_location %accumulate passed ##1 %accumulate failed ##1

{_test_interp_version}
_pass = ##2
actual = "Version: ${@$const.version}"
_ = %ifElse %eq @actual @$const.expected_version %accumulate passed ##1 %accumulate failed ##1

; ============================================================
; PASS 3: INTERPOLATION WITH VERBS
; ============================================================

{_test_interp_with_upper}
_pass = ##3
upper_name = %upper @$const.name
actual = "${@$const.greeting}, ${@upper_name}!"
expected = "Hello, WORLD!"
_ = %ifElse %eq @actual @expected %accumulate passed ##1 %accumulate failed ##1

{_test_interp_with_concat}
_pass = ##3
full = %concat @$const.first " " @$const.last
actual = "Name: ${@full}"
expected = "Name: John Doe"
_ = %ifElse %eq @actual @expected %accumulate passed ##1 %accumulate failed ##1

; ============================================================
; PASS 4: MIXED LITERAL AND INTERPOLATION
; ============================================================

{_test_interp_mixed}
_pass = ##4
actual = "User ${@$const.first} from ${@$const.city}"
expected = "User John from Austin"
_ = %ifElse %eq @actual @expected %accumulate passed ##1 %accumulate failed ##1

{_test_interp_prefix_suffix}
_pass = ##4
actual = "[${@$const.name}]"
expected = "[World]"
_ = %ifElse %eq @actual @expected %accumulate passed ##1 %accumulate failed ##1

; ============================================================
; TEST RESULT OUTPUT
; ============================================================
{TestResult}
verb = "interpolation"
passed = "@$accumulator.passed"
failed = "@$accumulator.failed"
total = %add @$accumulator.passed @$accumulator.failed
success = %eq @$accumulator.failed ##0
