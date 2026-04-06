{$}
odin = "1.0.0"
transform = "1.0.0"
direction = "json->json"

; ============================================================
; ARRAY VERBS SELF-TEST
; Tests: filter, flatten, distinct, sort, sortDesc, sortBy,
;        map, indexOf, at, slice, reverse, every, some,
;        find, findIndex, includes, concatArrays, zip,
;        groupBy, partition, take, drop, chunk, range,
;        compact, pluck, unique
; Note: count, sum, min, max, avg, first, last tested in
;       aggregation sections of other tests
; ============================================================

{$const}
; === BASE ARRAYS (defined inline in tests) ===
num_0 = ##0
num_1 = ##1
num_2 = ##2
num_3 = ##3
num_4 = ##4
num_5 = ##5

; === EXPECTED COUNTS ===
count_3 = ##3
count_5 = ##5

; === BOOLEAN VALUES ===
bool_true = ?true
bool_false = ?false

{$accumulator}
passed = ##0
failed = ##0

; ============================================================
; PASS 1: AT, SLICE, REVERSE TESTS
; ============================================================

{_internal_arrays}
_pass = ##1
nums = "[##1, ##2, ##3, ##4, ##5]"
strs = "[\"a\", \"b\", \"c\"]"
mixed = "[##1, ##2, ##1, ##3, ##2]"
nested = "[[##1, ##2], [##3, ##4]]"
withNulls = "[##1, ~, ##2, \"\", ##3]"

{_test_at_first}
_pass = ##1
actual = %at @_internal_arrays.nums ##0
_ = %ifElse %eq @actual @$const.num_1 %accumulate passed ##1 %accumulate failed ##1

{_test_at_middle}
_pass = ##1
actual = %at @_internal_arrays.nums ##2
_ = %ifElse %eq @actual @$const.num_3 %accumulate passed ##1 %accumulate failed ##1

{_test_at_last}
_pass = ##1
actual = %at @_internal_arrays.nums ##4
_ = %ifElse %eq @actual @$const.num_5 %accumulate passed ##1 %accumulate failed ##1

{_test_slice}
_pass = ##1
actual = %slice @_internal_arrays.nums ##1 ##3
count = %count @actual
_ = %ifElse %eq @count ##2 %accumulate passed ##1 %accumulate failed ##1

{_test_reverse}
_pass = ##1
actual = %reverse @_internal_arrays.nums
first = %at @actual ##0
_ = %ifElse %eq @first @$const.num_5 %accumulate passed ##1 %accumulate failed ##1

; ============================================================
; PASS 2: SORT, SORTDESC, DISTINCT/UNIQUE TESTS
; ============================================================

{_test_sort}
_pass = ##2
unsorted = "[##3, ##1, ##4, ##1, ##5]"
actual = %sort @unsorted
first = %at @actual ##0
_ = %ifElse %eq @first @$const.num_1 %accumulate passed ##1 %accumulate failed ##1

{_test_sortDesc}
_pass = ##2
unsorted = "[##3, ##1, ##4, ##1, ##5]"
actual = %sortDesc @unsorted
first = %at @actual ##0
_ = %ifElse %eq @first @$const.num_5 %accumulate passed ##1 %accumulate failed ##1

{_test_distinct}
_pass = ##2
actual = %distinct @_internal_arrays.mixed
count = %count @actual
; [1,2,1,3,2] -> [1,2,3] = 3 unique
_ = %ifElse %eq @count @$const.count_3 %accumulate passed ##1 %accumulate failed ##1

{_test_unique}
_pass = ##2
; unique is alias for distinct
actual = %unique @_internal_arrays.mixed
count = %count @actual
_ = %ifElse %eq @count @$const.count_3 %accumulate passed ##1 %accumulate failed ##1

; ============================================================
; PASS 3: FLATTEN, TAKE, DROP, COMPACT TESTS
; ============================================================

{_test_flatten}
_pass = ##3
actual = %flatten @_internal_arrays.nested
count = %count @actual
; [[1,2],[3,4]] -> [1,2,3,4] = 4 elements
_ = %ifElse %eq @count ##4 %accumulate passed ##1 %accumulate failed ##1

{_test_take}
_pass = ##3
actual = %take @_internal_arrays.nums ##3
count = %count @actual
_ = %ifElse %eq @count @$const.count_3 %accumulate passed ##1 %accumulate failed ##1

{_test_drop}
_pass = ##3
actual = %drop @_internal_arrays.nums ##2
count = %count @actual
_ = %ifElse %eq @count @$const.count_3 %accumulate passed ##1 %accumulate failed ##1

{_test_compact}
_pass = ##3
actual = %compact @_internal_arrays.withNulls
count = %count @actual
; [1, null, 2, "", 3] -> [1, 2, 3] = 3 elements
_ = %ifElse %eq @count @$const.count_3 %accumulate passed ##1 %accumulate failed ##1

; ============================================================
; PASS 4: INDEXOF, INCLUDES, FIND, FINDINDEX TESTS
; ============================================================

{_test_indexOf}
_pass = ##4
actual = %indexOf @_internal_arrays.nums ##3
_ = %ifElse %eq @actual ##2 %accumulate passed ##1 %accumulate failed ##1

{_test_indexOf_notfound}
_pass = ##4
actual = %indexOf @_internal_arrays.nums ##99
_ = %ifElse %eq @actual ##-1 %accumulate passed ##1 %accumulate failed ##1

{_test_includes_true}
_pass = ##4
actual = %includes @_internal_arrays.nums ##3
_ = %ifElse @actual %accumulate passed ##1 %accumulate failed ##1

{_test_includes_false}
_pass = ##4
actual = %includes @_internal_arrays.nums ##99
_ = %ifElse %not @actual %accumulate passed ##1 %accumulate failed ##1

; ============================================================
; PASS 5: EVERY, SOME TESTS
; ============================================================

{_test_every_true}
_pass = ##5
; All numbers are > 0
arr = "[##1, ##2, ##3]"
actual = %every @arr "" ">" ##0
_ = %ifElse @actual %accumulate passed ##1 %accumulate failed ##1

{_test_every_false}
_pass = ##5
; Not all numbers are > 2
arr = "[##1, ##2, ##3]"
actual = %every @arr "" ">" ##2
_ = %ifElse %not @actual %accumulate passed ##1 %accumulate failed ##1

{_test_some_true}
_pass = ##5
; Some numbers are > 2
arr = "[##1, ##2, ##3]"
actual = %some @arr "" ">" ##2
_ = %ifElse @actual %accumulate passed ##1 %accumulate failed ##1

{_test_some_false}
_pass = ##5
; No numbers are > 10
arr = "[##1, ##2, ##3]"
actual = %some @arr "" ">" ##10
_ = %ifElse %not @actual %accumulate passed ##1 %accumulate failed ##1

; ============================================================
; PASS 6: RANGE, CHUNK TESTS
; ============================================================

{_test_range}
_pass = ##6
actual = %range ##1 ##5
count = %count @actual
; range(1,5) = [1,2,3,4] = 4 elements
_ = %ifElse %eq @count ##4 %accumulate passed ##1 %accumulate failed ##1

{_test_range_with_step}
_pass = ##6
actual = %range ##0 ##10 ##2
count = %count @actual
; range(0,10,2) = [0,2,4,6,8] = 5 elements
_ = %ifElse %eq @count @$const.count_5 %accumulate passed ##1 %accumulate failed ##1

{_test_chunk}
_pass = ##6
arr = "[##1, ##2, ##3, ##4, ##5, ##6]"
actual = %chunk @arr ##2
count = %count @actual
; [1,2,3,4,5,6] chunked by 2 = [[1,2],[3,4],[5,6]] = 3 chunks
_ = %ifElse %eq @count @$const.count_3 %accumulate passed ##1 %accumulate failed ##1

; ============================================================
; PASS 7: CONCATARRAYS, ZIP TESTS
; ============================================================

{_test_concatArrays}
_pass = ##7
arr1 = "[##1, ##2]"
arr2 = "[##3, ##4]"
actual = %concatArrays @arr1 @arr2
count = %count @actual
_ = %ifElse %eq @count ##4 %accumulate passed ##1 %accumulate failed ##1

{_test_zip}
_pass = ##7
arr1 = "[##1, ##2, ##3]"
arr2 = "[\"a\", \"b\", \"c\"]"
actual = %zip @arr1 @arr2
count = %count @actual
; zip produces array of pairs
_ = %ifElse %eq @count @$const.count_3 %accumulate passed ##1 %accumulate failed ##1

; ============================================================
; PASS 8: JOIN TEST (from string but works with arrays)
; ============================================================

{_test_join}
_pass = ##8
actual = %join @_internal_arrays.strs "-"
_ = %ifElse %eq @actual "a-b-c" %accumulate passed ##1 %accumulate failed ##1

; ============================================================
; PASS 9: FILTER, FIND, FINDINDEX TESTS
; ============================================================

{_test_objects}
_pass = ##9
users = "[{\"name\": \"Alice\", \"age\": ##25}, {\"name\": \"Bob\", \"age\": ##30}, {\"name\": \"Carol\", \"age\": ##35}]"

{_test_filter}
_pass = ##9
; Filter users with age > 25
actual = %filter @_test_objects.users "age" ">" ##25
count = %count @actual
; Bob (30) and Carol (35) pass filter
_ = %ifElse %eq @count ##2 %accumulate passed ##1 %accumulate failed ##1

{_test_filter_eq}
_pass = ##9
; Filter users with age = 30
actual = %filter @_test_objects.users "age" "=" ##30
count = %count @actual
_ = %ifElse %eq @count ##1 %accumulate passed ##1 %accumulate failed ##1

{_test_find}
_pass = ##9
; Find first user with age > 25
actual = %find @_test_objects.users "age" ">" ##25
name = %get @actual "name" ""
_ = %ifElse %eq @name "Bob" %accumulate passed ##1 %accumulate failed ##1

{_test_findIndex}
_pass = ##9
; Find index of first user with age > 25
actual = %findIndex @_test_objects.users "age" ">" ##25
; Bob is at index 1
_ = %ifElse %eq @actual ##1 %accumulate passed ##1 %accumulate failed ##1

{_test_findIndex_notfound}
_pass = ##9
; Find index of user with age > 100 (none exist)
actual = %findIndex @_test_objects.users "age" ">" ##100
_ = %ifElse %eq @actual ##-1 %accumulate passed ##1 %accumulate failed ##1

; ============================================================
; PASS 10: SORTBY, MAP, PLUCK TESTS
; ============================================================

{_test_sortBy}
_pass = ##10
; Sort users by age
actual = %sortBy @_test_objects.users "age"
first = %at @actual ##0
firstName = %get @first "name" ""
; Alice (25) should be first
_ = %ifElse %eq @firstName "Alice" %accumulate passed ##1 %accumulate failed ##1

{_test_map}
_pass = ##10
; Map to extract names
actual = %map @_test_objects.users "name"
count = %count @actual
first = %at @actual ##0
_ = %ifElse %and %eq @count ##3 %eq @first "Alice" %accumulate passed ##1 %accumulate failed ##1

{_test_pluck}
_pass = ##10
; Pluck ages (same as map for simple field)
actual = %pluck @_test_objects.users "age"
sum = %sum @actual
; 25 + 30 + 35 = 90
_ = %ifElse %eq @sum ##90 %accumulate passed ##1 %accumulate failed ##1

; ============================================================
; PASS 11: GROUPBY, PARTITION TESTS
; ============================================================

{_test_group_data}
_pass = ##11
items = "[{\"category\": \"fruit\", \"name\": \"apple\"}, {\"category\": \"veg\", \"name\": \"carrot\"}, {\"category\": \"fruit\", \"name\": \"banana\"}]"

{_test_groupBy}
_pass = ##11
; Group items by category
actual = %groupBy @_test_group_data.items "category"
; Result is an object with keys for each category
fruitGroup = %get @actual "fruit" "[]"
fruitCount = %count @fruitGroup
; Two fruits: apple, banana
_ = %ifElse %eq @fruitCount ##2 %accumulate passed ##1 %accumulate failed ##1

{_test_partition}
_pass = ##11
; Partition users by age > 27 (split into two arrays)
actual = %partition @_test_objects.users "age" ">" ##27
; Returns [matching, non-matching]
matching = %at @actual ##0
matchCount = %count @matching
; Bob (30) and Carol (35) match
_ = %ifElse %eq @matchCount ##2 %accumulate passed ##1 %accumulate failed ##1

{_test_partition_nonmatching}
_pass = ##11
actual = %partition @_test_objects.users "age" ">" ##27
nonMatching = %at @actual ##1
nonMatchCount = %count @nonMatching
; Alice (25) doesn't match
_ = %ifElse %eq @nonMatchCount ##1 %accumulate passed ##1 %accumulate failed ##1

; ============================================================
; PASS 12: DEDUPE TESTS
; ============================================================

{_dedupe_data}
_pass = ##12
; Array with duplicate ids
items = "[{\"id\": ##1, \"name\": \"Alice\"}, {\"id\": ##2, \"name\": \"Bob\"}, {\"id\": ##1, \"name\": \"Alice2\"}, {\"id\": ##3, \"name\": \"Carol\"}]"

{_test_dedupe_basic}
_pass = ##12
; Dedupe by id - should keep first occurrence of each id
actual = %dedupe @_dedupe_data.items "id"
count = %count @actual
; Should have 3 unique ids (1, 2, 3)
_ = %ifElse %eq @count ##3 %accumulate passed ##1 %accumulate failed ##1

{_test_dedupe_first_kept}
_pass = ##12
; Verify first occurrence is kept
actual = %dedupe @_dedupe_data.items "id"
first = %at @actual ##0
firstName = %get @first "name" ""
; "Alice" (first id=1) should be kept, not "Alice2"
_ = %ifElse %eq @firstName "Alice" %accumulate passed ##1 %accumulate failed ##1

{_test_dedupe_preserves_order}
_pass = ##12
; Verify order is preserved (1, 2, 3)
actual = %dedupe @_dedupe_data.items "id"
third = %at @actual ##2
thirdId = %get @third "id" ##0
; Third item should have id=3 (Carol)
_ = %ifElse %eq @thirdId ##3 %accumulate passed ##1 %accumulate failed ##1

; ============================================================
; TEST RESULT OUTPUT
; ============================================================
{TestResult}
verb = "array"
passed = "@$accumulator.passed"
failed = "@$accumulator.failed"
total = %add @$accumulator.passed @$accumulator.failed
success = %eq @$accumulator.failed ##0
