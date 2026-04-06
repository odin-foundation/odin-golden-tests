{$}
odin = "1.0.0"
transform = "1.0.0"
direction = "json->json"

{$const}
; Test 1: true AND true = true
t1_a = ?true
t1_b = ?true
t1_expected = ?true

; Test 2: true AND false = false
t2_a = ?true
t2_b = ?false
t2_expected = ?false

; Test 3: false AND true = false
t3_a = ?false
t3_b = ?true
t3_expected = ?false

; Test 4: false AND false = false
t4_a = ?false
t4_b = ?false
t4_expected = ?false

{$accumulator}
passed = ##0
failed = ##0

{_test1}
_pass = ##1
actual = %and @$const.t1_a @$const.t1_b
_ = %ifElse %eq @actual @$const.t1_expected %accumulate passed ##1 %accumulate failed ##1

{_test2}
_pass = ##1
actual = %and @$const.t2_a @$const.t2_b
_ = %ifElse %eq @actual @$const.t2_expected %accumulate passed ##1 %accumulate failed ##1

{_test3}
_pass = ##1
actual = %and @$const.t3_a @$const.t3_b
_ = %ifElse %eq @actual @$const.t3_expected %accumulate passed ##1 %accumulate failed ##1

{_test4}
_pass = ##1
actual = %and @$const.t4_a @$const.t4_b
_ = %ifElse %eq @actual @$const.t4_expected %accumulate passed ##1 %accumulate failed ##1

{TestResult}
verb = "and"
passed = "@$accumulator.passed"
failed = "@$accumulator.failed"
total = %add @$accumulator.passed @$accumulator.failed
success = %eq @$accumulator.failed ##0
