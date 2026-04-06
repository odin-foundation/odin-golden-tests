{$}
odin = "1.0.0"
transform = "1.0.0"
direction = "json->json"

; ============================================================
; COLLECTION EXTRA VERBS SELF-TEST
; Tests: reduce, movingAvg, pivot, unpivot
; ============================================================

{$const}
; === EXPECTED VALUES ===
sum_150 = ##150
product_24 = ##24
count_3 = ##3
count_5 = ##5

; movingAvg window=3: [10,20,30,40,50]
; [0]: avg(10) = 10
; [1]: avg(10,20) = 15
; [2]: avg(10,20,30) = 20
; [3]: avg(20,30,40) = 30
; [4]: avg(30,40,50) = 40
mavg_0 = ##10
mavg_1 = ##15
mavg_2 = ##20
mavg_3 = ##30
mavg_4 = ##40

; pivot expected
pivot_width = ##100
pivot_height = ##200

{$accumulator}
passed = ##0
failed = ##0

; ============================================================
; INTERNAL ARRAYS
; ============================================================

{_internal_data}
_pass = ##1
prices = "[##10, ##20, ##30, ##40, ##50]"
factors = "[##2, ##3, ##4]"

; ============================================================
; REDUCE TESTS
; ============================================================

{_test_reduce_sum}
_pass = ##1
actual = %reduce @_internal_data.prices "add" ##0
_ = %ifElse %eq @actual @$const.sum_150 %accumulate passed ##1 %accumulate failed ##1

{_test_reduce_multiply}
_pass = ##1
actual = %reduce @_internal_data.factors "multiply" ##1
_ = %ifElse %eq @actual @$const.product_24 %accumulate passed ##1 %accumulate failed ##1

; ============================================================
; MOVING AVERAGE TESTS
; ============================================================

{_test_movingAvg_first}
_pass = ##2
result = %movingAvg @_internal_data.prices ##3
actual = %at @result ##0
_ = %ifElse %eq @actual @$const.mavg_0 %accumulate passed ##1 %accumulate failed ##1

{_test_movingAvg_second}
_pass = ##2
result = %movingAvg @_internal_data.prices ##3
actual = %at @result ##1
_ = %ifElse %eq @actual @$const.mavg_1 %accumulate passed ##1 %accumulate failed ##1

{_test_movingAvg_third}
_pass = ##2
result = %movingAvg @_internal_data.prices ##3
actual = %at @result ##2
_ = %ifElse %eq @actual @$const.mavg_2 %accumulate passed ##1 %accumulate failed ##1

{_test_movingAvg_fourth}
_pass = ##2
result = %movingAvg @_internal_data.prices ##3
actual = %at @result ##3
_ = %ifElse %eq @actual @$const.mavg_3 %accumulate passed ##1 %accumulate failed ##1

{_test_movingAvg_fifth}
_pass = ##2
result = %movingAvg @_internal_data.prices ##3
actual = %at @result ##4
_ = %ifElse %eq @actual @$const.mavg_4 %accumulate passed ##1 %accumulate failed ##1

{_test_movingAvg_count}
_pass = ##2
result = %movingAvg @_internal_data.prices ##3
actual = %count @result
_ = %ifElse %eq @actual @$const.count_5 %accumulate passed ##1 %accumulate failed ##1

; ============================================================
; PIVOT TESTS
; ============================================================

{_internal_pivot_data}
_pass = ##3
items = "[{\"name\": \"width\", \"value\": 100}, {\"name\": \"height\", \"value\": 200}, {\"name\": \"depth\", \"value\": 50}]"

{_test_pivot_basic}
_pass = ##3
result = %pivot @_internal_pivot_data.items "name" "value"
width = %get @result "width"
_ = %ifElse %eq @width @$const.pivot_width %accumulate passed ##1 %accumulate failed ##1

{_test_pivot_second_key}
_pass = ##3
result = %pivot @_internal_pivot_data.items "name" "value"
height = %get @result "height"
_ = %ifElse %eq @height @$const.pivot_height %accumulate passed ##1 %accumulate failed ##1

; ============================================================
; UNPIVOT TESTS
; ============================================================

{_internal_unpivot_data}
_pass = ##4
obj = "{\"width\": 100, \"height\": 200, \"depth\": 50}"

{_test_unpivot_count}
_pass = ##4
result = %unpivot @_internal_unpivot_data.obj "key" "value"
actual = %count @result
_ = %ifElse %eq @actual @$const.count_3 %accumulate passed ##1 %accumulate failed ##1

; ============================================================
; TEST RESULT OUTPUT
; ============================================================
{TestResult}
verb = "collection-extra"
passed = "@$accumulator.passed"
failed = "@$accumulator.failed"
total = %add @$accumulator.passed @$accumulator.failed
success = %eq @$accumulator.failed ##0
