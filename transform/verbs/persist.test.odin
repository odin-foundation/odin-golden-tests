{$}
odin = "1.0.0"
transform = "1.0.0"
direction = "json->json"

; ============================================================
; ACCUMULATOR PERSIST SELF-TEST
; Tests: Persist vs non-persist accumulator behavior across passes
; Verifies: Non-persist resets between passes, persist retains values
; ============================================================

{$accumulator}
; Non-persist accumulator (default) - should reset between passes
nonPersistCounter = ##0

; Persist accumulator - should retain value between passes
persistCounter = ##0
persistCounter._persist = ?true

; Edge case: Persist with non-zero initial value
persistWithInitial = ##100
persistWithInitial._persist = ?true

; Edge case: Persist with negative accumulation
persistNegative = ##0
persistNegative._persist = ?true

; Edge case: Explicit non-persist (false)
explicitNonPersist = ##0
explicitNonPersist._persist = ?false

; Test tracking accumulators
passed = ##0
failed = ##0

; ============================================================
; PASS 1: Accumulate initial values
; ============================================================

{_pass1_accumulate}
_pass = ##1
; Accumulate 5 to each counter
_a = %accumulate nonPersistCounter ##5
_b = %accumulate persistCounter ##5
_c = %accumulate persistWithInitial ##10
_d = %accumulate persistNegative ##-5
_e = %accumulate explicitNonPersist ##5

; ============================================================
; PASS 2: Verify reset behavior
; Non-persist should have reset to 0 at start of pass 2
; Persist should still be 5
; ============================================================

{_pass2_verify_nonpersist}
_pass = ##2
; Non-persist accumulator should have reset to 0 at start of pass 2
actual = "@$accumulator.nonPersistCounter"
expected = ##0
; If it's 0, the reset worked correctly
_ = %ifElse %eq @actual @expected %accumulate passed ##1 %accumulate failed ##1

{_pass2_verify_persist}
_pass = ##2
; Persist accumulator should still have value from pass 1
actual = "@$accumulator.persistCounter"
expected = ##5
_ = %ifElse %eq @actual @expected %accumulate passed ##1 %accumulate failed ##1

{_pass2_add_more}
_pass = ##2
; Add more to both to verify they both still work
_a = %accumulate nonPersistCounter ##3
_b = %accumulate persistCounter ##3

; ============================================================
; PASS 3: Verify values after pass 2
; Non-persist: started at 0, added 3, should be 3 at start then reset to 0
; Persist: started at 5, added 3, should be 8
; ============================================================

{_pass3_verify_nonpersist}
_pass = ##3
; Non-persist should have reset again
actual = "@$accumulator.nonPersistCounter"
expected = ##0
_ = %ifElse %eq @actual @expected %accumulate passed ##1 %accumulate failed ##1

{_pass3_verify_persist}
_pass = ##3
; Persist should have accumulated: 5 (pass1) + 3 (pass2) = 8
actual = "@$accumulator.persistCounter"
expected = ##8
_ = %ifElse %eq @actual @expected %accumulate passed ##1 %accumulate failed ##1

; ============================================================
; PASS 4: EDGE CASE VERIFICATION
; ============================================================

{_pass4_verify_persist_with_initial}
_pass = ##4
; Persist with non-zero initial: 100 (initial) + 10 (pass1) = 110
; Value should persist across passes 2 and 3
actual = "@$accumulator.persistWithInitial"
expected = ##110
_ = %ifElse %eq @actual @expected %accumulate passed ##1 %accumulate failed ##1

{_pass4_verify_persist_negative}
_pass = ##4
; Persist with negative: 0 (initial) + (-5) (pass1) = -5
actual = "@$accumulator.persistNegative"
expected = ##-5
_ = %ifElse %eq @actual @expected %accumulate passed ##1 %accumulate failed ##1

{_pass4_verify_explicit_non_persist}
_pass = ##4
; Explicit _persist=false should reset like default
; Should be 0 (reset at start of pass 4)
actual = "@$accumulator.explicitNonPersist"
expected = ##0
_ = %ifElse %eq @actual @expected %accumulate passed ##1 %accumulate failed ##1

{_pass4_accumulate_negative_more}
_pass = ##4
; Accumulate more negative to test continued negative accumulation
_a = %accumulate persistNegative ##-3

; ============================================================
; PASS 5: VERIFY CONTINUED NEGATIVE ACCUMULATION
; ============================================================

{_pass5_verify_negative_accumulated}
_pass = ##5
; Persist negative: -5 (pass1-4) + (-3) (pass4) = -8
actual = "@$accumulator.persistNegative"
expected = ##-8
_ = %ifElse %eq @actual @expected %accumulate passed ##1 %accumulate failed ##1

; ============================================================
; TEST RESULT OUTPUT
; ============================================================
{TestResult}
verb = "persist"
passed = "@$accumulator.passed"
failed = "@$accumulator.failed"
total = %add @$accumulator.passed @$accumulator.failed
success = %eq @$accumulator.failed ##0
; Final values for debugging
nonPersistFinal = "@$accumulator.nonPersistCounter"
persistFinal = "@$accumulator.persistCounter"
