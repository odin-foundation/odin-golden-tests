{$}
odin = "1.0.0"
transform = "1.0.0"
direction = "json->json"

; ============================================================
; NEW VERBS SELF-TEST
; Tests: distance, inBoundingBox, tokenize, wordCount,
;        levenshtein, soundex, sample, limit, assert,
;        toArray, toObject
; ============================================================

{$const}
; === GEO TEST VALUES ===
nyc_lat = #40.7128
nyc_lon = #-74.0060
la_lat = #34.0522
la_lon = #-118.2437

; === TEXT TEST VALUES ===
text_input = "hello world foo bar"
csv_line = "a,b,c,d"
word_text = "The quick brown fox"
empty_text = ""

; === FUZZY MATCHING VALUES ===
name1 = "Robert"
name2 = "Rupert"
str1 = "kitten"
str2 = "sitting"

; === ARRAY VALUES ===
numbers[0] = ##1
numbers[1] = ##2
numbers[2] = ##3
numbers[3] = ##4
numbers[4] = ##5

{$accumulator}
passed = ##0
failed = ##0

; ============================================================
; PASS 1: GEO VERBS
; ============================================================

{_test_distance_km}
_pass = ##1
; NYC to LA should be roughly 3935-3936 km
actual = %distance @$const.nyc_lat @$const.nyc_lon @$const.la_lat @$const.la_lon
in_range = %and %gt @actual #3935 %lt @actual #3936
_ = %ifElse @in_range %accumulate passed ##1 %accumulate failed ##1

{_test_inBoundingBox_true}
_pass = ##1
; Point (40, -75) inside box (39,-76) to (41,-74)
actual = %inBoundingBox #40.0 #-75.0 #39.0 #-76.0 #41.0 #-74.0
_ = %ifElse @actual %accumulate passed ##1 %accumulate failed ##1

{_test_inBoundingBox_false}
_pass = ##1
; Point (50, -75) outside box
actual = %inBoundingBox #50.0 #-75.0 #39.0 #-76.0 #41.0 #-74.0
_ = %ifElse %not @actual %accumulate passed ##1 %accumulate failed ##1

{_test_toRadians}
_pass = ##1
actual = %toRadians ##180
; Should be approximately pi (3.14159...)
expected = #3.14159
diff = %abs %subtract @actual @expected
_ = %ifElse %lt @diff #0.001 %accumulate passed ##1 %accumulate failed ##1

; ============================================================
; PASS 2: TEXT PROCESSING VERBS
; ============================================================

{_test_tokenize_whitespace}
_pass = ##2
actual = %tokenize @$const.text_input
count = %count @actual
_ = %ifElse %eq @count ##4 %accumulate passed ##1 %accumulate failed ##1

{_test_tokenize_delimiter}
_pass = ##2
actual = %tokenize @$const.csv_line ","
count = %count @actual
_ = %ifElse %eq @count ##4 %accumulate passed ##1 %accumulate failed ##1

{_test_wordCount}
_pass = ##2
actual = %wordCount @$const.word_text
_ = %ifElse %eq @actual ##4 %accumulate passed ##1 %accumulate failed ##1

{_test_wordCount_empty}
_pass = ##2
actual = %wordCount @$const.empty_text
_ = %ifElse %eq @actual ##0 %accumulate passed ##1 %accumulate failed ##1

; ============================================================
; PASS 3: FUZZY STRING MATCHING
; ============================================================

{_test_levenshtein_same}
_pass = ##3
actual = %levenshtein "hello" "hello"
_ = %ifElse %eq @actual ##0 %accumulate passed ##1 %accumulate failed ##1

{_test_levenshtein_diff}
_pass = ##3
actual = %levenshtein @$const.str1 @$const.str2
; kitten -> sitting = 3 edits
_ = %ifElse %eq @actual ##3 %accumulate passed ##1 %accumulate failed ##1

{_test_soundex_similar}
_pass = ##3
code1 = %soundex @$const.name1
code2 = %soundex @$const.name2
; Robert and Rupert should have same soundex
_ = %ifElse %eq @code1 @code2 %accumulate passed ##1 %accumulate failed ##1

; ============================================================
; PASS 4: SAMPLING VERBS
; ============================================================

{_test_limit}
_pass = ##4
actual = %limit @$const.numbers ##3
count = %count @actual
_ = %ifElse %eq @count ##3 %accumulate passed ##1 %accumulate failed ##1

{_test_sample}
_pass = ##4
; Sample 3 items with seed for reproducibility
actual = %sample @$const.numbers ##3 ##42
count = %count @actual
_ = %ifElse %eq @count ##3 %accumulate passed ##1 %accumulate failed ##1

; ============================================================
; PASS 5: VALIDATION VERBS
; ============================================================

{_test_assert_true}
_pass = ##5
actual = %assert ?true
_ = %ifElse @actual %accumulate passed ##1 %accumulate failed ##1

{_test_assert_false}
_pass = ##5
actual = %assert ?false
is_null = %isNull @actual
_ = %ifElse @is_null %accumulate passed ##1 %accumulate failed ##1

; ============================================================
; PASS 6: COLLECTION VERBS
; ============================================================

{_test_toArray_single}
_pass = ##6
actual = %toArray "single"
is_array = %isArray @actual
_ = %ifElse @is_array %accumulate passed ##1 %accumulate failed ##1

{_test_toArray_null}
_pass = ##6
actual = %toArray ~
is_array = %isArray @actual
count = %count @actual
both = %and @is_array %eq @count ##0
_ = %ifElse @both %accumulate passed ##1 %accumulate failed ##1

; ============================================================
; TEST RESULT OUTPUT
; ============================================================
{TestResult}
verb = "new-verbs"
passed = "@$accumulator.passed"
failed = "@$accumulator.failed"
total = %add @$accumulator.passed @$accumulator.failed
success = %eq @$accumulator.failed ##0
