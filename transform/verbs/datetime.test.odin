{$}
odin = "1.0.0"
transform = "1.0.0"
direction = "json->json"

; ============================================================
; DATETIME VERBS SELF-TEST
; Tests: parseDate, formatTime, formatTimestamp, parseTimestamp,
;        addDays, addMonths, addYears, addHours, addMinutes,
;        addSeconds, dateDiff, startOfDay, endOfDay, startOfMonth,
;        endOfMonth, startOfYear, endOfYear, dayOfWeek, weekOfYear,
;        quarter, isLeapYear, isBefore, isAfter, isBetween,
;        toUnix, fromUnix
; Note: formatDate, today, now tested elsewhere
; ============================================================

{$const}
; === REGEX PATTERNS ===
; ISO date pattern: YYYY-MM-DD
date_pattern = "^\\d{4}-\\d{2}-\\d{2}$"
; ISO timestamp pattern: YYYY-MM-DDTHH:mm:ss with optional timezone
timestamp_pattern = "^\\d{4}-\\d{2}-\\d{2}T\\d{2}:\\d{2}:\\d{2}"
; Time pattern: HH:mm:ss
time_pattern = "^\\d{2}:\\d{2}:\\d{2}$"

; === BASE DATE VALUES ===
date_2024_06_15 = "2024-06-15"
date_2024_01_01 = "2024-01-01"
date_2024_12_31 = "2024-12-31"
date_2023_06_15 = "2023-06-15"

; === TIMESTAMP VALUES ===
timestamp_full = "2024-06-15T14:30:45Z"
timestamp_midnight = "2024-06-15T00:00:00Z"
timestamp_end = "2024-06-15T23:59:59Z"

; === ADD DATE EXPECTED ===
addDays_7_expected = "2024-06-22"
addDays_neg_expected = "2024-06-08"
addMonths_1_expected = "2024-07-15"
addYears_1_expected = "2025-06-15"

; === DATE BOUNDARIES ===
startOfMonth_expected = "2024-06-01"
endOfMonth_expected = "2024-06-30"
startOfYear_expected = "2024-01-01"
endOfYear_expected = "2024-12-31"

; === DAY OF WEEK VALUES ===
; 2024-06-15 is Saturday (6 in JS, might be 6 or 7 depending on convention)
dayOfWeek_expected = ##6

; === WEEK OF YEAR VALUES ===
; Jan 1, 2024 is in week 1
weekOfYear_jan1_expected = ##1

; === QUARTER VALUES ===
quarter_jan = ##1
quarter_apr = ##2
quarter_jul = ##3
quarter_oct = ##4

; === LEAP YEAR VALUES ===
year_2024 = ##2024
year_2023 = ##2023
isLeap_2024_expected = ?true
isLeap_2023_expected = ?false

; === COMPARISON VALUES ===
isBefore_expected = ?true
isAfter_expected = ?true
isBetween_expected = ?true

; === UNIX TIMESTAMP VALUES ===
; 2024-01-01T00:00:00Z = 1704067200
unix_2024_01_01 = ##1704067200

{$accumulator}
passed = ##0
failed = ##0

; ============================================================
; PASS 1: ADD DAYS/MONTHS/YEARS TESTS
; ============================================================

{_test_addDays_positive}
_pass = ##1
actual = %addDays @$const.date_2024_06_15 ##7
formatted = %formatDate @actual "YYYY-MM-DD"
_ = %ifElse %eq @formatted @$const.addDays_7_expected %accumulate passed ##1 %accumulate failed ##1

{_test_addDays_negative}
_pass = ##1
actual = %addDays @$const.date_2024_06_15 ##-7
formatted = %formatDate @actual "YYYY-MM-DD"
_ = %ifElse %eq @formatted @$const.addDays_neg_expected %accumulate passed ##1 %accumulate failed ##1

{_test_addMonths}
_pass = ##1
actual = %addMonths @$const.date_2024_06_15 ##1
formatted = %formatDate @actual "YYYY-MM-DD"
_ = %ifElse %eq @formatted @$const.addMonths_1_expected %accumulate passed ##1 %accumulate failed ##1

{_test_addYears}
_pass = ##1
actual = %addYears @$const.date_2024_06_15 ##1
formatted = %formatDate @actual "YYYY-MM-DD"
_ = %ifElse %eq @formatted @$const.addYears_1_expected %accumulate passed ##1 %accumulate failed ##1

; ============================================================
; PASS 2: DATE BOUNDARY TESTS
; ============================================================

{_test_startOfMonth}
_pass = ##2
actual = %startOfMonth @$const.date_2024_06_15
formatted = %formatDate @actual "YYYY-MM-DD"
_ = %ifElse %eq @formatted @$const.startOfMonth_expected %accumulate passed ##1 %accumulate failed ##1

{_test_endOfMonth}
_pass = ##2
actual = %endOfMonth @$const.date_2024_06_15
formatted = %formatDate @actual "YYYY-MM-DD"
_ = %ifElse %eq @formatted @$const.endOfMonth_expected %accumulate passed ##1 %accumulate failed ##1

{_test_startOfYear}
_pass = ##2
actual = %startOfYear @$const.date_2024_06_15
formatted = %formatDate @actual "YYYY-MM-DD"
_ = %ifElse %eq @formatted @$const.startOfYear_expected %accumulate passed ##1 %accumulate failed ##1

{_test_endOfYear}
_pass = ##2
actual = %endOfYear @$const.date_2024_06_15
formatted = %formatDate @actual "YYYY-MM-DD"
_ = %ifElse %eq @formatted @$const.endOfYear_expected %accumulate passed ##1 %accumulate failed ##1

; ============================================================
; PASS 3: DAYOFWEEK, WEEKOFYEAR, QUARTER TESTS
; ============================================================

{_test_dayOfWeek}
_pass = ##3
actual = %dayOfWeek @$const.date_2024_06_15
_ = %ifElse %eq @actual @$const.dayOfWeek_expected %accumulate passed ##1 %accumulate failed ##1

{_test_weekOfYear}
_pass = ##3
actual = %weekOfYear @$const.date_2024_01_01
_ = %ifElse %eq @actual @$const.weekOfYear_jan1_expected %accumulate passed ##1 %accumulate failed ##1

{_test_quarter_q1}
_pass = ##3
actual = %quarter "2024-01-15"
_ = %ifElse %eq @actual @$const.quarter_jan %accumulate passed ##1 %accumulate failed ##1

{_test_quarter_q2}
_pass = ##3
actual = %quarter "2024-04-15"
_ = %ifElse %eq @actual @$const.quarter_apr %accumulate passed ##1 %accumulate failed ##1

{_test_quarter_q3}
_pass = ##3
actual = %quarter "2024-07-15"
_ = %ifElse %eq @actual @$const.quarter_jul %accumulate passed ##1 %accumulate failed ##1

{_test_quarter_q4}
_pass = ##3
actual = %quarter "2024-10-15"
_ = %ifElse %eq @actual @$const.quarter_oct %accumulate passed ##1 %accumulate failed ##1

; ============================================================
; PASS 4: ISLEAPYEAR TESTS
; ============================================================

{_test_isLeapYear_2024}
_pass = ##4
actual = %isLeapYear @$const.date_2024_01_01
_ = %ifElse %eq @actual @$const.isLeap_2024_expected %accumulate passed ##1 %accumulate failed ##1

{_test_isLeapYear_2023}
_pass = ##4
actual = %isLeapYear @$const.date_2023_06_15
_ = %ifElse %eq @actual @$const.isLeap_2023_expected %accumulate passed ##1 %accumulate failed ##1

; ============================================================
; PASS 5: DATE COMPARISON TESTS
; ============================================================

{_test_isBefore_true}
_pass = ##5
; 2023-06-15 is before 2024-06-15
actual = %isBefore @$const.date_2023_06_15 @$const.date_2024_06_15
_ = %ifElse %eq @actual @$const.isBefore_expected %accumulate passed ##1 %accumulate failed ##1

{_test_isBefore_false}
_pass = ##5
actual = %isBefore @$const.date_2024_06_15 @$const.date_2023_06_15
_ = %ifElse %not @actual %accumulate passed ##1 %accumulate failed ##1

{_test_isAfter_true}
_pass = ##5
; 2024-06-15 is after 2023-06-15
actual = %isAfter @$const.date_2024_06_15 @$const.date_2023_06_15
_ = %ifElse %eq @actual @$const.isAfter_expected %accumulate passed ##1 %accumulate failed ##1

{_test_isBetween_true}
_pass = ##5
; 2024-06-15 is between 2024-01-01 and 2024-12-31
actual = %isBetween @$const.date_2024_06_15 @$const.date_2024_01_01 @$const.date_2024_12_31
_ = %ifElse %eq @actual @$const.isBetween_expected %accumulate passed ##1 %accumulate failed ##1

{_test_isBetween_false}
_pass = ##5
; 2023-06-15 is NOT between 2024-01-01 and 2024-12-31
actual = %isBetween @$const.date_2023_06_15 @$const.date_2024_01_01 @$const.date_2024_12_31
_ = %ifElse %not @actual %accumulate passed ##1 %accumulate failed ##1

; ============================================================
; PASS 6: UNIX TIMESTAMP TESTS
; ============================================================

{_test_toUnix}
_pass = ##6
actual = %toUnix @$const.date_2024_01_01
_ = %ifElse %eq @actual @$const.unix_2024_01_01 %accumulate passed ##1 %accumulate failed ##1

{_test_fromUnix}
_pass = ##6
actual = %fromUnix @$const.unix_2024_01_01
formatted = %formatDate @actual "YYYY-MM-DD"
_ = %ifElse %eq @formatted @$const.date_2024_01_01 %accumulate passed ##1 %accumulate failed ##1

{_test_unix_roundtrip}
_pass = ##6
; toUnix then fromUnix should give same date
unix = %toUnix @$const.date_2024_06_15
back = %fromUnix @unix
formatted = %formatDate @back "YYYY-MM-DD"
_ = %ifElse %eq @formatted @$const.date_2024_06_15 %accumulate passed ##1 %accumulate failed ##1

; ============================================================
; PASS 7: DATEDIFF TESTS
; ============================================================

{_test_dateDiff_days}
_pass = ##7
; Diff between 2024-01-01 and 2024-01-08 = 7 days
actual = %dateDiff "2024-01-01" "2024-01-08" "days"
_ = %ifElse %eq @actual ##7 %accumulate passed ##1 %accumulate failed ##1

{_test_dateDiff_months}
_pass = ##7
; Diff between 2024-01-15 and 2024-06-15 = 5 months
actual = %dateDiff "2024-01-15" "2024-06-15" "months"
_ = %ifElse %eq @actual ##5 %accumulate passed ##1 %accumulate failed ##1

{_test_dateDiff_years}
_pass = ##7
; Diff between 2020-01-01 and 2024-01-01 = 4 years
actual = %dateDiff "2020-01-01" "2024-01-01" "years"
_ = %ifElse %eq @actual ##4 %accumulate passed ##1 %accumulate failed ##1

; ============================================================
; PASS 8: TODAY, NOW TESTS
; Note: Tests use @.input._test.* for known datetime values
; ============================================================

{_test_today_pattern}
_pass = ##8
; today returns ISO date: YYYY-MM-DD
actual = %today
matches = %match @actual @$const.date_pattern
_ = %ifElse @matches %accumulate passed ##1 %accumulate failed ##1

{_test_today_is_valid_date}
_pass = ##8
; today should be a valid date (can extract dayOfWeek 0-6)
td = %today
dow = %dayOfWeek @td
_ = %ifElse %between @dow ##0 ##6 %accumulate passed ##1 %accumulate failed ##1

{_test_now_pattern}
_pass = ##8
; now returns ISO timestamp: YYYY-MM-DDTHH:mm:ss...
actual = %now
matches = %match @actual @$const.timestamp_pattern
_ = %ifElse @matches %accumulate passed ##1 %accumulate failed ##1

{_test_now_contains_T}
_pass = ##8
; Timestamp should contain T separator between date and time
actual = %now
hasT = %contains @actual "T"
_ = %ifElse @hasT %accumulate passed ##1 %accumulate failed ##1

{_test_input_date_pattern}
_pass = ##8
; Verify input test date matches ISO date pattern
inputDate = "@.input._test.currentDate"
matches = %match @inputDate @$const.date_pattern
_ = %ifElse @matches %accumulate passed ##1 %accumulate failed ##1

{_test_input_timestamp_pattern}
_pass = ##8
; Verify input timestamp matches ISO timestamp pattern
inputTs = "@.input._test.currentTimestamp"
matches = %match @inputTs @$const.timestamp_pattern
_ = %ifElse @matches %accumulate passed ##1 %accumulate failed ##1

{_test_input_timestamp_value}
_pass = ##8
; Verify input timestamp can be formatted to exact time
inputTs = "@.input._test.currentTimestamp"
formatted = %formatTime @inputTs "HH:mm:ss"
_ = %ifElse %eq @formatted "14:30:45" %accumulate passed ##1 %accumulate failed ##1

; ============================================================
; PASS 9: FORMATTIME, PARSETIMESTAMP TESTS
; ============================================================

{_test_formatTime_hhmmss}
_pass = ##9
actual = %formatTime @$const.timestamp_full "HH:mm:ss"
_ = %ifElse %eq @actual "14:30:45" %accumulate passed ##1 %accumulate failed ##1

{_test_formatTime_hhmm}
_pass = ##9
actual = %formatTime @$const.timestamp_full "HH:mm"
_ = %ifElse %eq @actual "14:30" %accumulate passed ##1 %accumulate failed ##1

{_test_parseTimestamp}
_pass = ##9
; Parse a timestamp in a specific format
actual = %parseTimestamp "20240615143045" "YYYYMMDDHHmmss"
formatted = %formatTime @actual "HH:mm:ss"
_ = %ifElse %eq @formatted "14:30:45" %accumulate passed ##1 %accumulate failed ##1

; ============================================================
; PASS 10: STARTOFDAY, ENDOFDAY TESTS
; ============================================================

{_test_startOfDay}
_pass = ##10
actual = %startOfDay @$const.timestamp_full
formatted = %formatTime @actual "HH:mm:ss"
_ = %ifElse %eq @formatted "00:00:00" %accumulate passed ##1 %accumulate failed ##1

{_test_endOfDay}
_pass = ##10
actual = %endOfDay @$const.timestamp_full
formatted = %formatTime @actual "HH:mm:ss"
_ = %ifElse %eq @formatted "23:59:59" %accumulate passed ##1 %accumulate failed ##1

; ============================================================
; PASS 11: ADDHOURS, ADDMINUTES, ADDSECONDS TESTS
; ============================================================

{_test_addHours}
_pass = ##11
; Add 2 hours to 14:30:45 -> 16:30:45
actual = %addHours @$const.timestamp_full ##2
formatted = %formatTime @actual "HH:mm:ss"
_ = %ifElse %eq @formatted "16:30:45" %accumulate passed ##1 %accumulate failed ##1

{_test_addMinutes}
_pass = ##11
; Add 15 minutes to 14:30:45 -> 14:45:45
actual = %addMinutes @$const.timestamp_full ##15
formatted = %formatTime @actual "HH:mm:ss"
_ = %ifElse %eq @formatted "14:45:45" %accumulate passed ##1 %accumulate failed ##1

{_test_addSeconds}
_pass = ##11
; Add 15 seconds to 14:30:45 -> 14:31:00
actual = %addSeconds @$const.timestamp_full ##15
formatted = %formatTime @actual "HH:mm:ss"
_ = %ifElse %eq @formatted "14:31:00" %accumulate passed ##1 %accumulate failed ##1

{_test_addHours_negative}
_pass = ##11
; Subtract 2 hours from 14:30:45 -> 12:30:45
actual = %addHours @$const.timestamp_full ##-2
formatted = %formatTime @actual "HH:mm:ss"
_ = %ifElse %eq @formatted "12:30:45" %accumulate passed ##1 %accumulate failed ##1

; ============================================================
; PASS 12: DAYSBETWEENDATES TESTS
; ============================================================

{_test_daysBetweenDates_positive}
_pass = ##12
; 10 days from Jan 1 to Jan 11
actual = %daysBetweenDates "2024-01-01" "2024-01-11"
_ = %ifElse %eq @actual ##10 %accumulate passed ##1 %accumulate failed ##1

{_test_daysBetweenDates_negative}
_pass = ##12
; -10 days when reversed
actual = %daysBetweenDates "2024-01-11" "2024-01-01"
_ = %ifElse %eq @actual ##-10 %accumulate passed ##1 %accumulate failed ##1

{_test_daysBetweenDates_zero}
_pass = ##12
; Same date = 0 days
actual = %daysBetweenDates "2024-06-15" "2024-06-15"
_ = %ifElse %eq @actual ##0 %accumulate passed ##1 %accumulate failed ##1

{_test_daysBetweenDates_yearBoundary}
_pass = ##12
; 1 day from Dec 31 to Jan 1
actual = %daysBetweenDates "2023-12-31" "2024-01-01"
_ = %ifElse %eq @actual ##1 %accumulate passed ##1 %accumulate failed ##1

; ============================================================
; PASS 13: AGEFROMDATE TESTS
; ============================================================

{_test_ageFromDate_exact}
_pass = ##13
; Person born 1990-06-15, as of 2024-06-15 = exactly 34
actual = %ageFromDate "1990-06-15" "2024-06-15"
_ = %ifElse %eq @actual ##34 %accumulate passed ##1 %accumulate failed ##1

{_test_ageFromDate_beforeBirthday}
_pass = ##13
; Person born Dec 25, as of June 15 = hasn't had birthday yet
actual = %ageFromDate "1990-12-25" "2024-06-15"
_ = %ifElse %eq @actual ##33 %accumulate passed ##1 %accumulate failed ##1

{_test_ageFromDate_afterBirthday}
_pass = ##13
; Person born Jan 1, as of June 15 = already had birthday
actual = %ageFromDate "1990-01-01" "2024-06-15"
_ = %ifElse %eq @actual ##34 %accumulate passed ##1 %accumulate failed ##1

; ============================================================
; PASS 14: ISVALIDDATE TESTS
; ============================================================

{_test_isValidDate_valid}
_pass = ##14
; Valid date in YYYY-MM-DD format
actual = %isValidDate "2024-06-15" "YYYY-MM-DD"
_ = %ifElse @actual %accumulate passed ##1 %accumulate failed ##1

{_test_isValidDate_invalidMonth}
_pass = ##14
; Invalid month 13
actual = %isValidDate "2024-13-01" "YYYY-MM-DD"
_ = %ifElse %not @actual %accumulate passed ##1 %accumulate failed ##1

{_test_isValidDate_leapYearValid}
_pass = ##14
; Feb 29 is valid in leap year 2024
actual = %isValidDate "2024-02-29" "YYYY-MM-DD"
_ = %ifElse @actual %accumulate passed ##1 %accumulate failed ##1

{_test_isValidDate_leapYearInvalid}
_pass = ##14
; Feb 29 is invalid in non-leap year 2023
actual = %isValidDate "2023-02-29" "YYYY-MM-DD"
_ = %ifElse %not @actual %accumulate passed ##1 %accumulate failed ##1

{_test_isValidDate_mmddyyyy}
_pass = ##14
; Valid date in MM/DD/YYYY format
actual = %isValidDate "12/31/2024" "MM/DD/YYYY"
_ = %ifElse @actual %accumulate passed ##1 %accumulate failed ##1

; ============================================================
; TEST RESULT OUTPUT
; ============================================================
{TestResult}
verb = "datetime"
passed = "@$accumulator.passed"
failed = "@$accumulator.failed"
total = %add @$accumulator.passed @$accumulator.failed
success = %eq @$accumulator.failed ##0
