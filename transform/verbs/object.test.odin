{$}
odin = "1.0.0"
transform = "1.0.0"
direction = "json->json"

; ============================================================
; OBJECT VERBS SELF-TEST
; Tests: keys, values, entries, has, get, merge
; ============================================================

{$const}
; === BOOLEAN VALUES ===
bool_true = ?true
bool_false = ?false

; === STRING VALUES ===
str_a = "a"
str_b = "b"
str_c = "c"
str_name = "name"
str_age = "age"
str_city = "city"
str_missing = "missing"

; === NUMBER VALUES ===
num_0 = ##0
num_1 = ##1
num_2 = ##2
num_3 = ##3
num_25 = ##25

; === DEFAULT VALUES ===
default_val = "default"

{$accumulator}
passed = ##0
failed = ##0

; ============================================================
; PASS 1: KEYS TESTS
; ============================================================

{_internal_objects}
_pass = ##1
person = "{\"name\": \"John\", \"age\": ##25, \"city\": \"Austin\"}"
simple = "{\"a\": ##1, \"b\": ##2}"
empty = "{}"

{_test_keys_count}
_pass = ##1
actual = %keys @_internal_objects.person
count = %count @actual
_ = %ifElse %eq @count @$const.num_3 %accumulate passed ##1 %accumulate failed ##1

{_test_keys_simple}
_pass = ##1
actual = %keys @_internal_objects.simple
count = %count @actual
_ = %ifElse %eq @count @$const.num_2 %accumulate passed ##1 %accumulate failed ##1

{_test_keys_empty}
_pass = ##1
actual = %keys @_internal_objects.empty
count = %count @actual
_ = %ifElse %eq @count @$const.num_0 %accumulate passed ##1 %accumulate failed ##1

; ============================================================
; PASS 2: VALUES TESTS
; ============================================================

{_test_values_count}
_pass = ##2
actual = %values @_internal_objects.person
count = %count @actual
_ = %ifElse %eq @count @$const.num_3 %accumulate passed ##1 %accumulate failed ##1

{_test_values_simple}
_pass = ##2
actual = %values @_internal_objects.simple
count = %count @actual
_ = %ifElse %eq @count @$const.num_2 %accumulate passed ##1 %accumulate failed ##1

{_test_values_includes}
_pass = ##2
actual = %values @_internal_objects.simple
; Values should include 1
has1 = %includes @actual ##1
_ = %ifElse @has1 %accumulate passed ##1 %accumulate failed ##1

; ============================================================
; PASS 3: ENTRIES TESTS
; ============================================================

{_test_entries_count}
_pass = ##3
actual = %entries @_internal_objects.person
count = %count @actual
; entries returns array of [key, value] pairs
_ = %ifElse %eq @count @$const.num_3 %accumulate passed ##1 %accumulate failed ##1

{_test_entries_simple}
_pass = ##3
actual = %entries @_internal_objects.simple
count = %count @actual
_ = %ifElse %eq @count @$const.num_2 %accumulate passed ##1 %accumulate failed ##1

; ============================================================
; PASS 4: HAS TESTS
; ============================================================

{_test_has_true}
_pass = ##4
actual = %has @_internal_objects.person "name"
_ = %ifElse @actual %accumulate passed ##1 %accumulate failed ##1

{_test_has_false}
_pass = ##4
actual = %has @_internal_objects.person "missing"
_ = %ifElse %not @actual %accumulate passed ##1 %accumulate failed ##1

{_test_has_simple}
_pass = ##4
actual = %has @_internal_objects.simple "a"
_ = %ifElse @actual %accumulate passed ##1 %accumulate failed ##1

; ============================================================
; PASS 5: GET TESTS
; ============================================================

{_test_get_string}
_pass = ##5
actual = %get @_internal_objects.person "name"
_ = %ifElse %eq @actual "John" %accumulate passed ##1 %accumulate failed ##1

{_test_get_number}
_pass = ##5
actual = %get @_internal_objects.person "age"
_ = %ifElse %eq @actual @$const.num_25 %accumulate passed ##1 %accumulate failed ##1

{_test_get_simple}
_pass = ##5
actual = %get @_internal_objects.simple "a"
_ = %ifElse %eq @actual @$const.num_1 %accumulate passed ##1 %accumulate failed ##1

{_test_get_with_default}
_pass = ##5
actual = %get @_internal_objects.person "missing" "default"
_ = %ifElse %eq @actual @$const.default_val %accumulate passed ##1 %accumulate failed ##1

; ============================================================
; PASS 6: MERGE TESTS
; ============================================================

{_test_merge_count}
_pass = ##6
obj1 = "{\"a\": ##1, \"b\": ##2}"
obj2 = "{\"c\": ##3}"
merged = %merge @obj1 @obj2
keys = %keys @merged
count = %count @keys
_ = %ifElse %eq @count @$const.num_3 %accumulate passed ##1 %accumulate failed ##1

{_test_merge_override}
_pass = ##6
obj1 = "{\"a\": ##1, \"b\": ##2}"
obj2 = "{\"a\": ##99}"
merged = %merge @obj1 @obj2
; Second object should override first
val = %get @merged "a"
_ = %ifElse %eq @val ##99 %accumulate passed ##1 %accumulate failed ##1

{_test_merge_preserves}
_pass = ##6
obj1 = "{\"a\": ##1, \"b\": ##2}"
obj2 = "{\"c\": ##3}"
merged = %merge @obj1 @obj2
hasA = %has @merged "a"
hasB = %has @merged "b"
hasC = %has @merged "c"
allPresent = %and @hasA %and @hasB @hasC
_ = %ifElse @allPresent %accumulate passed ##1 %accumulate failed ##1

; ============================================================
; TEST RESULT OUTPUT
; ============================================================
{TestResult}
verb = "object"
passed = "@$accumulator.passed"
failed = "@$accumulator.failed"
total = %add @$accumulator.passed @$accumulator.failed
success = %eq @$accumulator.failed ##0
