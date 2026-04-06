{$}
odin = "1.0.0"
transform = "1.0.0"
direction = "json->json"

; ============================================================
; BUSINESS DATE VERBS SELF-TEST
; Tests: businessDays, nextBusinessDay
; ============================================================

{$const}
; === BUSINESS DAYS TEST VALUES ===
; 2024-01-15 is Monday
monday = "2024-01-15"
; Add 5 business days to Monday -> next Monday
monday_plus5 = "2024-01-22"
; Add 1 business day to Monday -> Tuesday
monday_plus1 = "2024-01-16"
; Add 10 business days to Monday -> 2 weeks of weekdays
monday_plus10 = "2024-01-29"

; 2024-01-19 is Friday
friday = "2024-01-19"
; Add 1 business day to Friday -> Monday
friday_plus1 = "2024-01-22"
; Add 5 business days to Friday -> next Friday
friday_plus5 = "2024-01-26"

; 2024-01-20 is Saturday
saturday = "2024-01-20"
; Next business day from Saturday -> Monday
saturday_next = "2024-01-22"

; 2024-01-21 is Sunday
sunday = "2024-01-21"
; Next business day from Sunday -> Monday
sunday_next = "2024-01-22"

; Already a business day (Monday)
monday_next = "2024-01-15"

; Wednesday
wednesday = "2024-01-17"
wednesday_next = "2024-01-17"
; Add 3 business days to Wednesday -> Monday (skips weekend)
wednesday_plus3 = "2024-01-22"

; Saturday start: 2024-01-20
; businessDays from Saturday should step off weekend first
saturday_plus1 = "2024-01-22"
saturday_plus5 = "2024-01-26"
saturday_plus10 = "2024-02-02"

; Sunday start: 2024-01-21
sunday_plus1 = "2024-01-22"
sunday_plus5 = "2024-01-26"

; Large count: Monday + 25 business days = 5 full weeks
monday_plus25 = "2024-02-19"

; Negative: Friday - 5 business days = previous Friday
friday_minus5 = "2024-01-12"

{$accumulator}
passed = ##0
failed = ##0

; ============================================================
; BUSINESS DAYS TESTS
; ============================================================

{_test_businessDays_mon_plus5}
_pass = ##1
actual = %businessDays @$const.monday ##5
_ = %ifElse %eq @actual @$const.monday_plus5 %accumulate passed ##1 %accumulate failed ##1

{_test_businessDays_mon_plus1}
_pass = ##1
actual = %businessDays @$const.monday ##1
_ = %ifElse %eq @actual @$const.monday_plus1 %accumulate passed ##1 %accumulate failed ##1

{_test_businessDays_mon_plus10}
_pass = ##1
actual = %businessDays @$const.monday ##10
_ = %ifElse %eq @actual @$const.monday_plus10 %accumulate passed ##1 %accumulate failed ##1

{_test_businessDays_fri_plus1}
_pass = ##1
; Friday + 1 business day = next Monday
actual = %businessDays @$const.friday ##1
_ = %ifElse %eq @actual @$const.friday_plus1 %accumulate passed ##1 %accumulate failed ##1

{_test_businessDays_fri_plus5}
_pass = ##1
actual = %businessDays @$const.friday ##5
_ = %ifElse %eq @actual @$const.friday_plus5 %accumulate passed ##1 %accumulate failed ##1

{_test_businessDays_wed_plus3}
_pass = ##1
; Wed + 3 business days = Mon (Thu, Fri, skip Sat/Sun, Mon)
actual = %businessDays @$const.wednesday ##3
_ = %ifElse %eq @actual @$const.wednesday_plus3 %accumulate passed ##1 %accumulate failed ##1

{_test_businessDays_sat_plus1}
_pass = ##1
; Saturday + 1 business day = Monday
actual = %businessDays @$const.saturday ##1
_ = %ifElse %eq @actual @$const.saturday_plus1 %accumulate passed ##1 %accumulate failed ##1

{_test_businessDays_sat_plus5}
_pass = ##1
; Saturday + 5 business days = Friday
actual = %businessDays @$const.saturday ##5
_ = %ifElse %eq @actual @$const.saturday_plus5 %accumulate passed ##1 %accumulate failed ##1

{_test_businessDays_sat_plus10}
_pass = ##1
; Saturday + 10 business days = 2 weeks from Monday
actual = %businessDays @$const.saturday ##10
_ = %ifElse %eq @actual @$const.saturday_plus10 %accumulate passed ##1 %accumulate failed ##1

{_test_businessDays_sun_plus1}
_pass = ##1
; Sunday + 1 business day = Monday
actual = %businessDays @$const.sunday ##1
_ = %ifElse %eq @actual @$const.sunday_plus1 %accumulate passed ##1 %accumulate failed ##1

{_test_businessDays_sun_plus5}
_pass = ##1
; Sunday + 5 business days = Friday
actual = %businessDays @$const.sunday ##5
_ = %ifElse %eq @actual @$const.sunday_plus5 %accumulate passed ##1 %accumulate failed ##1

{_test_businessDays_mon_plus25}
_pass = ##1
; Monday + 25 business days = 5 full weeks
actual = %businessDays @$const.monday ##25
_ = %ifElse %eq @actual @$const.monday_plus25 %accumulate passed ##1 %accumulate failed ##1

{_test_businessDays_fri_minus5}
_pass = ##1
; Friday - 5 business days = previous Friday
actual = %businessDays @$const.friday ##-5
_ = %ifElse %eq @actual @$const.friday_minus5 %accumulate passed ##1 %accumulate failed ##1

; ============================================================
; NEXT BUSINESS DAY TESTS
; ============================================================

{_test_nextBusinessDay_saturday}
_pass = ##2
actual = %nextBusinessDay @$const.saturday
_ = %ifElse %eq @actual @$const.saturday_next %accumulate passed ##1 %accumulate failed ##1

{_test_nextBusinessDay_sunday}
_pass = ##2
actual = %nextBusinessDay @$const.sunday
_ = %ifElse %eq @actual @$const.sunday_next %accumulate passed ##1 %accumulate failed ##1

{_test_nextBusinessDay_monday}
_pass = ##2
; Monday is already a business day, should return same day
actual = %nextBusinessDay @$const.monday
_ = %ifElse %eq @actual @$const.monday_next %accumulate passed ##1 %accumulate failed ##1

{_test_nextBusinessDay_wednesday}
_pass = ##2
actual = %nextBusinessDay @$const.wednesday
_ = %ifElse %eq @actual @$const.wednesday_next %accumulate passed ##1 %accumulate failed ##1

; ============================================================
; TEST RESULT OUTPUT
; ============================================================
{TestResult}
verb = "business-date"
passed = "@$accumulator.passed"
failed = "@$accumulator.failed"
total = %add @$accumulator.passed @$accumulator.failed
success = %eq @$accumulator.failed ##0
