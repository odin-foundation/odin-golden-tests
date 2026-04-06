{$}
odin = "1.0.0"
transform = "1.0.0"
direction = "json->json"

; ============================================================
; CUSTOM VERBS SELF-TEST
; Tests: Custom verb syntax (%&namespace.verb)
; Verifies: Namespace parsing, argument passing, error handling
; Note: Actual custom verb implementations are SDK-specific,
;       but parsing and invocation patterns are universal
; ============================================================

{$const}
; === CUSTOM VERB SYNTAX VALUES ===
test_value = "hello world"
test_number = ##42
test_data = "sensitive-data"

; === EXPECTED RESULTS ===
; Custom verbs return their inputs wrapped with verb info for testing
simple_expected = "hello world"
with_args_expected = ##42

{$accumulator}
passed = ##0
failed = ##0

; ============================================================
; PASS 1: CUSTOM VERB PARSING TESTS
; These tests verify custom verb syntax is correctly parsed
; ============================================================

{_test_custom_verb_simple}
_pass = ##1
; Simple custom verb with single argument
actual = %&com.example.echo @$const.test_value
; In test mode, custom verbs echo their input
_ = %ifElse %eq @actual @$const.simple_expected %accumulate passed ##1 %accumulate failed ##1

{_test_custom_verb_nested_namespace}
_pass = ##1
; Custom verb with deeply nested namespace
actual = %&org.company.department.processData @$const.test_value
_ = %ifElse %eq @actual @$const.simple_expected %accumulate passed ##1 %accumulate failed ##1

{_test_custom_verb_with_multiple_args}
_pass = ##1
; Custom verb with multiple arguments
actual = %&com.acme.format @$const.test_value @$const.test_number
_ = %ifElse %not %isNull @actual %accumulate passed ##1 %accumulate failed ##1

{_test_custom_verb_with_literal_args}
_pass = ##1
; Custom verb with literal string argument
actual = %&com.util.wrap @$const.test_value "prefix" "suffix"
_ = %ifElse %not %isNull @actual %accumulate passed ##1 %accumulate failed ##1

{_test_custom_verb_chained}
_pass = ##1
; Custom verb result passed to built-in verb
actual = %upper %&com.example.echo @$const.test_value
expected = "HELLO WORLD"
_ = %ifElse %eq @actual @expected %accumulate passed ##1 %accumulate failed ##1

{_test_custom_verb_as_input}
_pass = ##1
; Built-in verb result passed to custom verb
actual = %&com.example.echo "%lower @$const.test_value"
_ = %ifElse %eq @actual @$const.simple_expected %accumulate passed ##1 %accumulate failed ##1

; ============================================================
; PASS 2: RESERVED NAMESPACE TESTS
; These test error handling for reserved namespaces
; ============================================================

{_test_reserved_namespace_odin}
_pass = ##2
; org.odin namespace is reserved - should work but warn
actual = %&org.odin.test @$const.test_value
; Implementation should allow but may emit warning
_ = %ifElse %not %isNull @actual %accumulate passed ##1 %accumulate failed ##1

{_test_reserved_namespace_foundation}
_pass = ##2
; foundation.odin namespace is reserved - should work but warn
actual = %&foundation.odin.test @$const.test_value
_ = %ifElse %not %isNull @actual %accumulate passed ##1 %accumulate failed ##1

; ============================================================
; PASS 3: EDGE CASE TESTS
; ============================================================

{_test_custom_verb_null_input}
_pass = ##3
; Custom verb with null input
null_val = ~
actual = %&com.example.echo @null_val
isNull = %isNull @actual
_ = %ifElse @isNull %accumulate passed ##1 %accumulate failed ##1

{_test_custom_verb_empty_string}
_pass = ##3
; Custom verb with empty string input
empty = ""
actual = %&com.example.echo @empty
isEmpty = %eq @actual ""
_ = %ifElse @isEmpty %accumulate passed ##1 %accumulate failed ##1

{_test_custom_verb_numeric_input}
_pass = ##3
; Custom verb with numeric input
actual = %&com.math.process @$const.test_number
_ = %ifElse %not %isNull @actual %accumulate passed ##1 %accumulate failed ##1

; ============================================================
; TEST RESULT OUTPUT
; ============================================================
{TestResult}
verb = "custom-verbs"
passed = "@$accumulator.passed"
failed = "@$accumulator.failed"
total = %add @$accumulator.passed @$accumulator.failed
success = %eq @$accumulator.failed ##0
