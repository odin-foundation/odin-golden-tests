{$}
odin = "1.0.0"
transform = "1.0.0"
direction = "json->json"

; ============================================================
; CORE VERBS SELF-TEST
; Tests: trim, trimLeft, trimRight, coalesce, ifNull, ifEmpty
; Note: concat, upper, lower, ifElse, lookup, lookupDefault
;       are tested in other self-tests (insurance.test.odin)
; ============================================================

{$const}
; === TRIM TEST VALUES ===
trim_input = "  hello world  "
trim_expected = "hello world"
trimLeft_expected = "hello world  "
trimRight_expected = "  hello world"
trim_tabs = "\t\nhello\t\n"
trim_tabs_expected = "hello"

; === COALESCE TEST VALUES ===
null_val = ~
empty_str = ""
val_first = "first"
val_second = "second"
coalesce_expected = "first"
coalesce_null_expected = "second"

; === IFNULL TEST VALUES ===
ifnull_val = "original"
ifnull_default = "default"
ifnull_expected = "original"
ifnull_null_expected = "default"

; === IFEMPTY TEST VALUES ===
ifempty_val = "original"
ifempty_default = "default"
ifempty_expected = "original"
ifempty_empty_expected = "default"

; === REVERSE LOOKUP VALUES ===
; Using lookup table defined below

{$accumulator}
passed = ##0
failed = ##0

; === LOOKUP TABLE FOR REVERSE LOOKUP ===
{$table.STATUS[code, name]}
"A", "Active"
"P", "Pending"
"C", "Cancelled"

; ============================================================
; PASS 1: TRIM TESTS
; ============================================================

{_test_trim_spaces}
_pass = ##1
actual = %trim @$const.trim_input
_ = %ifElse %eq @actual @$const.trim_expected %accumulate passed ##1 %accumulate failed ##1

{_test_trimLeft_spaces}
_pass = ##1
actual = %trimLeft @$const.trim_input
_ = %ifElse %eq @actual @$const.trimLeft_expected %accumulate passed ##1 %accumulate failed ##1

{_test_trimRight_spaces}
_pass = ##1
actual = %trimRight @$const.trim_input
_ = %ifElse %eq @actual @$const.trimRight_expected %accumulate passed ##1 %accumulate failed ##1

{_test_trim_tabs}
_pass = ##1
actual = %trim @$const.trim_tabs
_ = %ifElse %eq @actual @$const.trim_tabs_expected %accumulate passed ##1 %accumulate failed ##1

{_test_trim_empty}
_pass = ##1
actual = %trim @$const.empty_str
_ = %ifElse %eq @actual @$const.empty_str %accumulate passed ##1 %accumulate failed ##1

{_test_trim_already_trimmed}
_pass = ##1
actual = %trim @$const.val_first
_ = %ifElse %eq @actual @$const.val_first %accumulate passed ##1 %accumulate failed ##1

; ============================================================
; PASS 2: COALESCE TESTS
; ============================================================

{_test_coalesce_first_nonnull}
_pass = ##2
actual = %coalesce @$const.val_first @$const.val_second
_ = %ifElse %eq @actual @$const.coalesce_expected %accumulate passed ##1 %accumulate failed ##1

{_test_coalesce_skip_null}
_pass = ##2
actual = %coalesce @$const.null_val @$const.val_second
_ = %ifElse %eq @actual @$const.coalesce_null_expected %accumulate passed ##1 %accumulate failed ##1

{_test_coalesce_skip_empty}
_pass = ##2
; coalesce should skip empty string and return second
actual = %coalesce @$const.empty_str @$const.val_second
_ = %ifElse %eq @actual @$const.coalesce_null_expected %accumulate passed ##1 %accumulate failed ##1

{_test_coalesce_three_values}
_pass = ##2
actual = %coalesce @$const.null_val @$const.null_val @$const.val_first
_ = %ifElse %eq @actual @$const.coalesce_expected %accumulate passed ##1 %accumulate failed ##1

; ============================================================
; PASS 3: IFNULL TESTS
; ============================================================

{_test_ifnull_nonnull}
_pass = ##3
actual = %ifNull @$const.ifnull_val @$const.ifnull_default
_ = %ifElse %eq @actual @$const.ifnull_expected %accumulate passed ##1 %accumulate failed ##1

{_test_ifnull_null}
_pass = ##3
actual = %ifNull @$const.null_val @$const.ifnull_default
_ = %ifElse %eq @actual @$const.ifnull_null_expected %accumulate passed ##1 %accumulate failed ##1

{_test_ifnull_empty_is_not_null}
_pass = ##3
; empty string is NOT null, so ifNull should return empty string
actual = %ifNull @$const.empty_str @$const.ifnull_default
_ = %ifElse %eq @actual @$const.empty_str %accumulate passed ##1 %accumulate failed ##1

; ============================================================
; PASS 4: IFEMPTY TESTS
; ============================================================

{_test_ifempty_nonempty}
_pass = ##4
actual = %ifEmpty @$const.ifempty_val @$const.ifempty_default
_ = %ifElse %eq @actual @$const.ifempty_expected %accumulate passed ##1 %accumulate failed ##1

{_test_ifempty_empty}
_pass = ##4
actual = %ifEmpty @$const.empty_str @$const.ifempty_default
_ = %ifElse %eq @actual @$const.ifempty_empty_expected %accumulate passed ##1 %accumulate failed ##1

{_test_ifempty_null_is_empty}
_pass = ##4
; null is considered "empty"
actual = %ifEmpty @$const.null_val @$const.ifempty_default
_ = %ifElse %eq @actual @$const.ifempty_empty_expected %accumulate passed ##1 %accumulate failed ##1

; ============================================================
; PASS 5: LOOKUP (REVERSE DIRECTION) TESTS
; ============================================================

{_test_reverseLookup_found}
_pass = ##5
; Reverse lookup: find code where name = "Active" -> "A"
actual = %lookup STATUS.code "name" "Active"
_ = %ifElse %eq @actual "A" %accumulate passed ##1 %accumulate failed ##1

{_test_reverseLookup_found_2}
_pass = ##5
; Reverse lookup: find code where name = "Pending" -> "P"
actual = %lookup STATUS.code "name" "Pending"
_ = %ifElse %eq @actual "P" %accumulate passed ##1 %accumulate failed ##1

{_test_reverseLookup_not_found}
_pass = ##5
; Reverse lookup: find code where name = "Unknown" -> null
actual = %lookup STATUS.code "name" "Unknown"
isNull = %isNull @actual
_ = %ifElse @isNull %accumulate passed ##1 %accumulate failed ##1

; ============================================================
; TEST RESULT OUTPUT
; ============================================================
{TestResult}
verb = "core"
passed = "@$accumulator.passed"
failed = "@$accumulator.failed"
total = %add @$accumulator.passed @$accumulator.failed
success = %eq @$accumulator.failed ##0
