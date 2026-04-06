{$}
odin = "1.0.0"
transform = "1.0.0"
direction = "json->json"

; ============================================================
; IFELSE BRANCH VERIFICATION TEST
; This test verifies that the ifElse pattern correctly
; takes the THEN branch on true and ELSE branch on false.
;
; KEY TEST: Tests 3 & 4 FLIP the pattern to prove else branch
; is actually taken when condition is false (not just falling through)
; ============================================================

{$accumulator}
passed = ##0
failed = ##0

; ============================================================
; TEST 1: TRUE CONDITION with normal pattern
; eq ##1 ##1 = TRUE -> takes THEN branch -> accumulates passed
; ============================================================

{_test_true_normal}
_pass = ##1
_ = %ifElse %eq ##1 ##1 %accumulate passed ##1 %accumulate failed ##1

; ============================================================
; TEST 2: Another TRUE with gt
; gt ##5 ##3 = TRUE -> takes THEN branch -> accumulates passed
; ============================================================

{_test_true_gt}
_pass = ##1
_ = %ifElse %gt ##5 ##3 %accumulate passed ##1 %accumulate failed ##1

; ============================================================
; TEST 3: FALSE CONDITION with FLIPPED pattern
; eq ##1 ##0 = FALSE -> takes ELSE branch -> accumulates passed
; (We flip the pattern: ELSE=passed, THEN=failed)
; If ifElse is broken and always takes THEN, this would fail!
; ============================================================

{_test_false_flipped}
_pass = ##1
; FLIPPED: failed first, passed second - so FALSE -> passed
_ = %ifElse %eq ##1 ##0 %accumulate failed ##1 %accumulate passed ##1

; ============================================================
; TEST 4: Another FALSE with gt, FLIPPED pattern
; gt ##2 ##5 = FALSE -> takes ELSE branch -> accumulates passed
; ============================================================

{_test_false_gt_flipped}
_pass = ##1
; FLIPPED: failed first, passed second - so FALSE -> passed
_ = %ifElse %gt ##2 ##5 %accumulate failed ##1 %accumulate passed ##1

; ============================================================
; VERIFICATION RESULT
; All 4 tests should increment passed (0 failed)
; Tests 1-2 prove TRUE takes THEN branch
; Tests 3-4 prove FALSE takes ELSE branch (via flipped pattern)
; ============================================================
{TestResult}
verb = "ifelse-verification"
passed = "@$accumulator.passed"
failed = "@$accumulator.failed"
total = %add @$accumulator.passed @$accumulator.failed
success = %eq @$accumulator.failed ##0
