{$}
odin = "1.0.0"
transform = "1.0.0"
direction = "json->json"

; ============================================================
; STRING VERBS SELF-TEST
; Tests: capitalize, length, contains, startsWith, endsWith,
;        replace, padRight, pad, truncate, split, join,
;        replaceRegex, reverseString, repeat, slugify,
;        normalizeSpace, leftOf, rightOf, wrap, center,
;        match, extract
; Note: upper, lower, titleCase, concat, substring, padLeft, mask,
;       camelCase, snakeCase, kebabCase, pascalCase tested elsewhere
; ============================================================

{$const}
; === CAPITALIZE TEST VALUES ===
cap_input = "hello world"
cap_expected = "Hello world"
cap_single = "h"
cap_single_expected = "H"

; === LENGTH TEST VALUES ===
len_input = "hello"
len_expected = ##5
len_empty = ""
len_empty_expected = ##0

; === CONTAINS TEST VALUES ===
contains_hay = "hello world"
contains_needle = "world"
contains_missing = "xyz"
contains_expected = ?true
contains_missing_expected = ?false

; === STARTSWITH/ENDSWITH TEST VALUES ===
str_test = "hello world"
starts_prefix = "hello"
starts_wrong = "world"
ends_suffix = "world"
ends_wrong = "hello"
starts_expected = ?true
ends_expected = ?true

; === REPLACE TEST VALUES ===
replace_input = "hello world"
replace_old = "world"
replace_new = "universe"
replace_expected = "hello universe"

; === PADRIGHT TEST VALUES ===
pad_input = "hi"
pad_len = ##5
pad_char = "-"
padRight_expected = "hi---"
pad_expected = "-hi--"

; === TRUNCATE TEST VALUES ===
trunc_input = "hello world"
trunc_len = ##5
trunc_expected = "hello"
trunc_ellipsis_expected = "he..."

; === SPLIT/JOIN TEST VALUES ===
split_input = "a,b,c"
split_delim = ","
join_delim = "-"

; === REPLACEREGEX TEST VALUES ===
regex_input = "test123abc456"
regex_pattern = "[0-9]+"
regex_replace = "X"
regex_expected = "testXabcX"

; === REVERSESTRING TEST VALUES ===
reverse_input = "hello"
reverse_expected = "olleh"
reverse_empty = ""

; === REPEAT TEST VALUES ===
repeat_input = "ab"
repeat_count = ##3
repeat_expected = "ababab"
repeat_zero_expected = ""

; === SLUGIFY TEST VALUES ===
slugify_input = "Hello World!"
slugify_expected = "hello-world"

; === NORMALIZESPACE TEST VALUES ===
normalize_input = "  hello   world  "
normalize_expected = "hello world"

; === LEFTOF/RIGHTOF TEST VALUES ===
split_str = "a.b.c"
split_dot = "."
leftOf_expected = "a"
rightOf_expected = "b.c"

; === CENTER TEST VALUES ===
center_input = "hi"
center_width = ##6
center_expected = "--hi--"

; === MATCH TEST VALUES ===
match_input = "test123"
match_pattern = "[0-9]+"
match_expected = ?true
match_no_expected = ?false

; === EXTRACT TEST VALUES ===
extract_input = "test123abc"
extract_pattern = "([0-9]+)"
extract_expected = "123"

{$accumulator}
passed = ##0
failed = ##0

; ============================================================
; PASS 1: CAPITALIZE AND LENGTH TESTS
; ============================================================

{_test_capitalize}
_pass = ##1
actual = %capitalize @$const.cap_input
_ = %ifElse %eq @actual @$const.cap_expected %accumulate passed ##1 %accumulate failed ##1

{_test_capitalize_single}
_pass = ##1
actual = %capitalize @$const.cap_single
_ = %ifElse %eq @actual @$const.cap_single_expected %accumulate passed ##1 %accumulate failed ##1

{_test_length}
_pass = ##1
actual = %length @$const.len_input
_ = %ifElse %eq @actual @$const.len_expected %accumulate passed ##1 %accumulate failed ##1

{_test_length_empty}
_pass = ##1
actual = %length @$const.len_empty
_ = %ifElse %eq @actual @$const.len_empty_expected %accumulate passed ##1 %accumulate failed ##1

; ============================================================
; PASS 2: CONTAINS, STARTSWITH, ENDSWITH TESTS
; ============================================================

{_test_contains_true}
_pass = ##2
actual = %contains @$const.contains_hay @$const.contains_needle
_ = %ifElse %eq @actual @$const.contains_expected %accumulate passed ##1 %accumulate failed ##1

{_test_contains_false}
_pass = ##2
actual = %contains @$const.contains_hay @$const.contains_missing
_ = %ifElse %eq @actual @$const.contains_missing_expected %accumulate passed ##1 %accumulate failed ##1

{_test_startsWith_true}
_pass = ##2
actual = %startsWith @$const.str_test @$const.starts_prefix
_ = %ifElse %eq @actual @$const.starts_expected %accumulate passed ##1 %accumulate failed ##1

{_test_startsWith_false}
_pass = ##2
actual = %startsWith @$const.str_test @$const.starts_wrong
_ = %ifElse %eq @actual @$const.contains_missing_expected %accumulate passed ##1 %accumulate failed ##1

{_test_endsWith_true}
_pass = ##2
actual = %endsWith @$const.str_test @$const.ends_suffix
_ = %ifElse %eq @actual @$const.ends_expected %accumulate passed ##1 %accumulate failed ##1

{_test_endsWith_false}
_pass = ##2
actual = %endsWith @$const.str_test @$const.ends_wrong
_ = %ifElse %eq @actual @$const.contains_missing_expected %accumulate passed ##1 %accumulate failed ##1

; ============================================================
; PASS 3: REPLACE, PADRIGHT, PAD, TRUNCATE TESTS
; ============================================================

{_test_replace}
_pass = ##3
actual = %replace @$const.replace_input @$const.replace_old @$const.replace_new
_ = %ifElse %eq @actual @$const.replace_expected %accumulate passed ##1 %accumulate failed ##1

{_test_padRight}
_pass = ##3
actual = %padRight @$const.pad_input @$const.pad_len @$const.pad_char
_ = %ifElse %eq @actual @$const.padRight_expected %accumulate passed ##1 %accumulate failed ##1

{_test_pad}
_pass = ##3
actual = %pad @$const.pad_input @$const.pad_len @$const.pad_char
_ = %ifElse %eq @actual @$const.pad_expected %accumulate passed ##1 %accumulate failed ##1

{_test_truncate}
_pass = ##3
actual = %truncate @$const.trunc_input @$const.trunc_len
_ = %ifElse %eq @actual @$const.trunc_expected %accumulate passed ##1 %accumulate failed ##1

{_test_truncate_ellipsis}
_pass = ##3
actual = %truncate @$const.trunc_input @$const.trunc_len "..."
_ = %ifElse %eq @actual @$const.trunc_ellipsis_expected %accumulate passed ##1 %accumulate failed ##1

; ============================================================
; PASS 4: SPLIT, JOIN, REPLACEREGEX TESTS
; ============================================================

{_test_split}
_pass = ##4
actual = %split @$const.split_input @$const.split_delim
; Check the result is an array with 3 elements
count = %count @actual
_ = %ifElse %eq @count ##3 %accumulate passed ##1 %accumulate failed ##1

{_test_replaceRegex}
_pass = ##4
actual = %replaceRegex @$const.regex_input @$const.regex_pattern @$const.regex_replace
_ = %ifElse %eq @actual @$const.regex_expected %accumulate passed ##1 %accumulate failed ##1

; ============================================================
; PASS 5: REVERSESTRING, REPEAT TESTS
; ============================================================

{_test_reverseString}
_pass = ##5
actual = %reverseString @$const.reverse_input
_ = %ifElse %eq @actual @$const.reverse_expected %accumulate passed ##1 %accumulate failed ##1

{_test_reverseString_empty}
_pass = ##5
actual = %reverseString @$const.reverse_empty
_ = %ifElse %eq @actual @$const.reverse_empty %accumulate passed ##1 %accumulate failed ##1

{_test_repeat}
_pass = ##5
actual = %repeat @$const.repeat_input @$const.repeat_count
_ = %ifElse %eq @actual @$const.repeat_expected %accumulate passed ##1 %accumulate failed ##1

{_test_repeat_zero}
_pass = ##5
actual = %repeat @$const.repeat_input ##0
_ = %ifElse %eq @actual @$const.repeat_zero_expected %accumulate passed ##1 %accumulate failed ##1

; ============================================================
; PASS 6: SLUGIFY, NORMALIZESPACE TESTS
; ============================================================

{_test_slugify}
_pass = ##6
actual = %slugify @$const.slugify_input
_ = %ifElse %eq @actual @$const.slugify_expected %accumulate passed ##1 %accumulate failed ##1

{_test_normalizeSpace}
_pass = ##6
actual = %normalizeSpace @$const.normalize_input
_ = %ifElse %eq @actual @$const.normalize_expected %accumulate passed ##1 %accumulate failed ##1

; ============================================================
; PASS 7: LEFTOF, RIGHTOF, CENTER TESTS
; ============================================================

{_test_leftOf}
_pass = ##7
actual = %leftOf @$const.split_str @$const.split_dot
_ = %ifElse %eq @actual @$const.leftOf_expected %accumulate passed ##1 %accumulate failed ##1

{_test_rightOf}
_pass = ##7
actual = %rightOf @$const.split_str @$const.split_dot
_ = %ifElse %eq @actual @$const.rightOf_expected %accumulate passed ##1 %accumulate failed ##1

{_test_center}
_pass = ##7
actual = %center @$const.center_input @$const.center_width @$const.pad_char
_ = %ifElse %eq @actual @$const.center_expected %accumulate passed ##1 %accumulate failed ##1

; ============================================================
; PASS 8: MATCH, EXTRACT TESTS
; ============================================================

{_test_match_true}
_pass = ##8
actual = %match @$const.match_input @$const.match_pattern
_ = %ifElse %eq @actual @$const.match_expected %accumulate passed ##1 %accumulate failed ##1

{_test_match_false}
_pass = ##8
actual = %match @$const.cap_input @$const.match_pattern
_ = %ifElse %eq @actual @$const.match_no_expected %accumulate passed ##1 %accumulate failed ##1

{_test_extract}
_pass = ##8
actual = %extract @$const.extract_input @$const.extract_pattern ##1
_ = %ifElse %eq @actual @$const.extract_expected %accumulate passed ##1 %accumulate failed ##1

; ============================================================
; PASS 9: WRAP TESTS
; ============================================================

{_test_wrap}
_pass = ##9
; wrap splits text at specified width
input = "This is a long string that should be wrapped"
actual = %wrap @input ##20
; Result should be an array of wrapped lines
count = %count @actual
; Should have at least 2 lines
_ = %ifElse %gte @count ##2 %accumulate passed ##1 %accumulate failed ##1

{_test_wrap_short}
_pass = ##9
; Short text should not wrap
input = "short"
actual = %wrap @input ##20
count = %count @actual
; Should have exactly 1 line
_ = %ifElse %eq @count ##1 %accumulate passed ##1 %accumulate failed ##1

{_test_wrap_exact}
_pass = ##9
; Text exactly at width should not wrap
input = "12345678901234567890"
actual = %wrap @input ##20
count = %count @actual
_ = %ifElse %eq @count ##1 %accumulate passed ##1 %accumulate failed ##1

; ============================================================
; PASS 10: MATCHES, STRIPACCENTS, CLEAN TESTS
; ============================================================

{_test_matches_true}
_pass = ##10
; matches is alias for match, testing basic pattern
actual = %matches "test123" "\\d+"
_ = %ifElse @actual %accumulate passed ##1 %accumulate failed ##1

{_test_matches_false}
_pass = ##10
; Full line match should fail
actual = %matches "test" "^\\d+$"
_ = %ifElse %not @actual %accumulate passed ##1 %accumulate failed ##1

{_test_stripAccents_cafe}
_pass = ##10
actual = %stripAccents "caf\u00E9"
expected = "cafe"
_ = %ifElse %eq @actual @expected %accumulate passed ##1 %accumulate failed ##1

{_test_stripAccents_resume}
_pass = ##10
actual = %stripAccents "r\u00E9sum\u00E9"
expected = "resume"
_ = %ifElse %eq @actual @expected %accumulate passed ##1 %accumulate failed ##1

{_test_stripAccents_plain}
_pass = ##10
; Plain text should pass through unchanged
actual = %stripAccents "hello world"
expected = "hello world"
_ = %ifElse %eq @actual @expected %accumulate passed ##1 %accumulate failed ##1

{_test_clean_whitespace}
_pass = ##10
; clean collapses multiple whitespace and trims
actual = %clean "  hello   world  "
expected = "hello world"
_ = %ifElse %eq @actual @expected %accumulate passed ##1 %accumulate failed ##1

{_test_clean_nbsp}
_pass = ##10
; clean normalizes non-breaking space to regular space
actual = %clean "hello\u00A0world"
expected = "hello world"
_ = %ifElse %eq @actual @expected %accumulate passed ##1 %accumulate failed ##1

{_test_clean_empty}
_pass = ##10
; clean on empty string returns empty
actual = %clean ""
expected = ""
_ = %ifElse %eq @actual @expected %accumulate passed ##1 %accumulate failed ##1

; ============================================================
; TEST RESULT OUTPUT
; ============================================================
{TestResult}
verb = "string"
passed = "@$accumulator.passed"
failed = "@$accumulator.failed"
total = %add @$accumulator.passed @$accumulator.failed
success = %eq @$accumulator.failed ##0
