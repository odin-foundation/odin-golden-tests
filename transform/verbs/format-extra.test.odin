{$}
odin = "1.0.0"
transform = "1.0.0"
direction = "json->json"

; ============================================================
; FORMAT EXTRA VERBS SELF-TEST
; Tests: formatDuration, formatPhone, formatTimestamp, parseDate
; ============================================================

{$const}
; === FORMAT DURATION VALUES ===
dur_2h30m = "PT2H30M"
dur_2h30m_expected = "2 hours, 30 minutes"
dur_1h = "PT1H"
dur_1h_expected = "1 hour"
dur_45m = "PT45M"
dur_45m_expected = "45 minutes"
dur_30s = "PT30S"
dur_30s_expected = "30 seconds"
dur_1h30m15s = "PT1H30M15S"
dur_1h30m15s_expected = "1 hour, 30 minutes, 15 seconds"
dur_1d = "P1D"
dur_1d_expected = "1 day"
dur_2d3h = "P2DT3H"
dur_2d3h_expected = "2 days, 3 hours"

; === FORMAT PHONE VALUES ===
phone_us = "2125551234"
phone_us_expected = "(212) 555-1234"
phone_us_11 = "12125551234"
phone_us_11_expected = "+1 (212) 555-1234"

; === FORMAT TIMESTAMP VALUES ===
ts_input = "2024-06-15T14:30:45Z"
ts_pattern1 = "YYYY-MM-DD HH:mm:ss"
ts_expected1 = "2024-06-15 14:30:45"
ts_pattern2 = "MM/DD/YYYY"
ts_expected2 = "06/15/2024"
ts_pattern3 = "HH:mm"
ts_expected3 = "14:30"

; === PARSE DATE VALUES ===
date_mmddyyyy = "06152024"
date_mmddyyyy_fmt = "MMDDYYYY"
date_mmddyyyy_expected = "2024-06-15"
date_slash = "01/20/2024"
date_slash_fmt = "MM/DD/YYYY"
date_slash_expected = "2024-01-20"
date_dash = "15-06-2024"
date_dash_fmt = "DD-MM-YYYY"
date_dash_expected = "2024-06-15"
date_yyyymmdd = "20240315"
date_yyyymmdd_fmt = "YYYYMMDD"
date_yyyymmdd_expected = "2024-03-15"

{$accumulator}
passed = ##0
failed = ##0

; ============================================================
; FORMAT DURATION TESTS
; ============================================================

{_test_formatDuration_2h30m}
_pass = ##1
actual = %formatDuration @$const.dur_2h30m
_ = %ifElse %eq @actual @$const.dur_2h30m_expected %accumulate passed ##1 %accumulate failed ##1

{_test_formatDuration_1h}
_pass = ##1
actual = %formatDuration @$const.dur_1h
_ = %ifElse %eq @actual @$const.dur_1h_expected %accumulate passed ##1 %accumulate failed ##1

{_test_formatDuration_45m}
_pass = ##1
actual = %formatDuration @$const.dur_45m
_ = %ifElse %eq @actual @$const.dur_45m_expected %accumulate passed ##1 %accumulate failed ##1

{_test_formatDuration_30s}
_pass = ##1
actual = %formatDuration @$const.dur_30s
_ = %ifElse %eq @actual @$const.dur_30s_expected %accumulate passed ##1 %accumulate failed ##1

{_test_formatDuration_1h30m15s}
_pass = ##1
actual = %formatDuration @$const.dur_1h30m15s
_ = %ifElse %eq @actual @$const.dur_1h30m15s_expected %accumulate passed ##1 %accumulate failed ##1

{_test_formatDuration_1d}
_pass = ##1
actual = %formatDuration @$const.dur_1d
_ = %ifElse %eq @actual @$const.dur_1d_expected %accumulate passed ##1 %accumulate failed ##1

{_test_formatDuration_2d3h}
_pass = ##1
actual = %formatDuration @$const.dur_2d3h
_ = %ifElse %eq @actual @$const.dur_2d3h_expected %accumulate passed ##1 %accumulate failed ##1

; ============================================================
; FORMAT PHONE TESTS
; ============================================================

{_test_formatPhone_us_10digit}
_pass = ##2
actual = %formatPhone @$const.phone_us "US"
_ = %ifElse %eq @actual @$const.phone_us_expected %accumulate passed ##1 %accumulate failed ##1

{_test_formatPhone_us_11digit}
_pass = ##2
actual = %formatPhone @$const.phone_us_11 "US"
_ = %ifElse %eq @actual @$const.phone_us_11_expected %accumulate passed ##1 %accumulate failed ##1

; ============================================================
; FORMAT TIMESTAMP TESTS
; ============================================================

{_test_formatTimestamp_datetime}
_pass = ##3
actual = %formatTimestamp @$const.ts_input @$const.ts_pattern1
_ = %ifElse %eq @actual @$const.ts_expected1 %accumulate passed ##1 %accumulate failed ##1

{_test_formatTimestamp_dateonly}
_pass = ##3
actual = %formatTimestamp @$const.ts_input @$const.ts_pattern2
_ = %ifElse %eq @actual @$const.ts_expected2 %accumulate passed ##1 %accumulate failed ##1

{_test_formatTimestamp_timeonly}
_pass = ##3
actual = %formatTimestamp @$const.ts_input @$const.ts_pattern3
_ = %ifElse %eq @actual @$const.ts_expected3 %accumulate passed ##1 %accumulate failed ##1

; ============================================================
; PARSE DATE TESTS
; ============================================================

{_test_parseDate_mmddyyyy}
_pass = ##4
actual = %parseDate @$const.date_mmddyyyy @$const.date_mmddyyyy_fmt
_ = %ifElse %eq @actual @$const.date_mmddyyyy_expected %accumulate passed ##1 %accumulate failed ##1

{_test_parseDate_slash}
_pass = ##4
actual = %parseDate @$const.date_slash @$const.date_slash_fmt
_ = %ifElse %eq @actual @$const.date_slash_expected %accumulate passed ##1 %accumulate failed ##1

{_test_parseDate_dash_dmy}
_pass = ##4
actual = %parseDate @$const.date_dash @$const.date_dash_fmt
_ = %ifElse %eq @actual @$const.date_dash_expected %accumulate passed ##1 %accumulate failed ##1

{_test_parseDate_yyyymmdd}
_pass = ##4
actual = %parseDate @$const.date_yyyymmdd @$const.date_yyyymmdd_fmt
_ = %ifElse %eq @actual @$const.date_yyyymmdd_expected %accumulate passed ##1 %accumulate failed ##1

; ============================================================
; TEST RESULT OUTPUT
; ============================================================
{TestResult}
verb = "format-extra"
passed = "@$accumulator.passed"
failed = "@$accumulator.failed"
total = %add @$accumulator.passed @$accumulator.failed
success = %eq @$accumulator.failed ##0
