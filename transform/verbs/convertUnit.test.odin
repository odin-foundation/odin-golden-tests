{$}
odin = "1.0.0"
transform = "1.0.0"
direction = "json->json"

; ============================================================
; CONVERT UNIT SELF-TEST
; Tests: convertUnit across all 8 unit families
; Families: mass, length, volume, speed, area, data, time, temperature
; All conversions rounded to 6 decimal places
; ============================================================

{$const}
; === SHARED VALUES ===
v100 = #100
v1 = #1
v0 = #0
v25 = #25

; === MASS EXPECTED ===
kg100_to_g = #100000
kg100_to_lb = #220.46226
kg100_to_oz = #3527.39619
kg100_to_ton = #0.110231
kg100_to_tonne = #0.1
lb1_to_kg = #0.453592
g1000_to_kg = #1

; === LENGTH EXPECTED ===
mi1_to_km = #1.609344
mi1_to_m = #1609.344
mi1_to_ft = #5280
mi1_to_yd = #1760
m1_to_cm = #100
m1_to_in = #39.370079
in12_to_ft = #1

; === VOLUME EXPECTED ===
gal1_to_L = #3.78541
gal1_to_qt = #4
gal1_to_floz = #127.999957
L1_to_mL = #1000
L1_to_gal = #0.264172

; === TEMPERATURE EXPECTED ===
c100_to_f = #212
c100_to_k = #373.15
f32_to_c = #0
f32_to_k = #273.15
f72_to_c = #22.222222
k0_to_c = #-273.15
k0_to_f = #-459.67
neg40_c_to_f = #-40

; === SPEED EXPECTED ===
kph100_to_mph = #62.137119
kph100_to_mps = #27.7778
mph60_to_kph = #96.56064

; === AREA EXPECTED ===
acre1_to_sqm = #4046.8564
acre1_to_hectare = #0.404686
sqkm1_to_sqmi = #0.386102
sqkm1_to_hectare = #100

; === DATA EXPECTED ===
gb1_to_mb = #1024
gb1_to_kb = #1048576
gb1_to_b = #1073741824
gb1_to_tb = #0.000977
mb2048_to_gb = #2

; === TIME EXPECTED ===
hr1_to_min = #60
hr1_to_s = #3600
hr1_to_ms = #3600000
day1_to_hr = #24
day1_to_min = #1440

{$accumulator}
passed = ##0
failed = ##0

; ============================================================
; MASS CONVERSIONS (kg, g, mg, lb, oz, ton, tonne)
; ============================================================

{_test_mass_kg_to_g}
_pass = ##1
actual = %convertUnit @$const.v100 "kg" "g"
_ = %ifElse %eq @actual @$const.kg100_to_g %accumulate passed ##1 %accumulate failed ##1

{_test_mass_kg_to_lb}
_pass = ##1
actual = %convertUnit @$const.v100 "kg" "lb"
_ = %ifElse %eq @actual @$const.kg100_to_lb %accumulate passed ##1 %accumulate failed ##1

{_test_mass_kg_to_oz}
_pass = ##1
actual = %convertUnit @$const.v100 "kg" "oz"
_ = %ifElse %eq @actual @$const.kg100_to_oz %accumulate passed ##1 %accumulate failed ##1

{_test_mass_kg_to_ton}
_pass = ##1
actual = %convertUnit @$const.v100 "kg" "ton"
_ = %ifElse %eq @actual @$const.kg100_to_ton %accumulate passed ##1 %accumulate failed ##1

{_test_mass_kg_to_tonne}
_pass = ##1
actual = %convertUnit @$const.v100 "kg" "tonne"
_ = %ifElse %eq @actual @$const.kg100_to_tonne %accumulate passed ##1 %accumulate failed ##1

{_test_mass_lb_to_kg}
_pass = ##1
actual = %convertUnit @$const.v1 "lb" "kg"
_ = %ifElse %eq @actual @$const.lb1_to_kg %accumulate passed ##1 %accumulate failed ##1

{_test_mass_g_to_kg}
_pass = ##1
actual = %convertUnit #1000 "g" "kg"
_ = %ifElse %eq @actual @$const.g1000_to_kg %accumulate passed ##1 %accumulate failed ##1

; ============================================================
; LENGTH CONVERSIONS (m, km, cm, mm, mi, ft, in, yd)
; ============================================================

{_test_length_mi_to_km}
_pass = ##2
actual = %convertUnit @$const.v1 "mi" "km"
_ = %ifElse %eq @actual @$const.mi1_to_km %accumulate passed ##1 %accumulate failed ##1

{_test_length_mi_to_m}
_pass = ##2
actual = %convertUnit @$const.v1 "mi" "m"
_ = %ifElse %eq @actual @$const.mi1_to_m %accumulate passed ##1 %accumulate failed ##1

{_test_length_mi_to_ft}
_pass = ##2
actual = %convertUnit @$const.v1 "mi" "ft"
_ = %ifElse %eq @actual @$const.mi1_to_ft %accumulate passed ##1 %accumulate failed ##1

{_test_length_mi_to_yd}
_pass = ##2
actual = %convertUnit @$const.v1 "mi" "yd"
_ = %ifElse %eq @actual @$const.mi1_to_yd %accumulate passed ##1 %accumulate failed ##1

{_test_length_m_to_cm}
_pass = ##2
actual = %convertUnit @$const.v1 "m" "cm"
_ = %ifElse %eq @actual @$const.m1_to_cm %accumulate passed ##1 %accumulate failed ##1

{_test_length_m_to_in}
_pass = ##2
actual = %convertUnit @$const.v1 "m" "in"
_ = %ifElse %eq @actual @$const.m1_to_in %accumulate passed ##1 %accumulate failed ##1

{_test_length_12in_to_ft}
_pass = ##2
actual = %convertUnit #12 "in" "ft"
_ = %ifElse %eq @actual @$const.in12_to_ft %accumulate passed ##1 %accumulate failed ##1

; ============================================================
; VOLUME CONVERSIONS (L, mL, gal, qt, pt, cup, floz)
; ============================================================

{_test_volume_gal_to_L}
_pass = ##3
actual = %convertUnit @$const.v1 "gal" "L"
_ = %ifElse %eq @actual @$const.gal1_to_L %accumulate passed ##1 %accumulate failed ##1

{_test_volume_gal_to_qt}
_pass = ##3
actual = %convertUnit @$const.v1 "gal" "qt"
_ = %ifElse %eq @actual @$const.gal1_to_qt %accumulate passed ##1 %accumulate failed ##1

{_test_volume_gal_to_floz}
_pass = ##3
actual = %convertUnit @$const.v1 "gal" "floz"
_ = %ifElse %eq @actual @$const.gal1_to_floz %accumulate passed ##1 %accumulate failed ##1

{_test_volume_L_to_mL}
_pass = ##3
actual = %convertUnit @$const.v1 "L" "mL"
_ = %ifElse %eq @actual @$const.L1_to_mL %accumulate passed ##1 %accumulate failed ##1

{_test_volume_L_to_gal}
_pass = ##3
actual = %convertUnit @$const.v1 "L" "gal"
_ = %ifElse %eq @actual @$const.L1_to_gal %accumulate passed ##1 %accumulate failed ##1

; ============================================================
; TEMPERATURE CONVERSIONS (C, F, K) — formula-based
; ============================================================

{_test_temp_c_to_f_boiling}
_pass = ##4
actual = %convertUnit @$const.v100 "C" "F"
_ = %ifElse %eq @actual @$const.c100_to_f %accumulate passed ##1 %accumulate failed ##1

{_test_temp_c_to_k_boiling}
_pass = ##4
actual = %convertUnit @$const.v100 "C" "K"
_ = %ifElse %eq @actual @$const.c100_to_k %accumulate passed ##1 %accumulate failed ##1

{_test_temp_f_to_c_freezing}
_pass = ##4
actual = %convertUnit #32 "F" "C"
_ = %ifElse %eq @actual @$const.f32_to_c %accumulate passed ##1 %accumulate failed ##1

{_test_temp_f_to_k_freezing}
_pass = ##4
actual = %convertUnit #32 "F" "K"
_ = %ifElse %eq @actual @$const.f32_to_k %accumulate passed ##1 %accumulate failed ##1

{_test_temp_f_to_c_room}
_pass = ##4
actual = %convertUnit #72 "F" "C"
_ = %ifElse %eq @actual @$const.f72_to_c %accumulate passed ##1 %accumulate failed ##1

{_test_temp_k_to_c_absolute_zero}
_pass = ##4
actual = %convertUnit @$const.v0 "K" "C"
_ = %ifElse %eq @actual @$const.k0_to_c %accumulate passed ##1 %accumulate failed ##1

{_test_temp_k_to_f_absolute_zero}
_pass = ##4
actual = %convertUnit @$const.v0 "K" "F"
_ = %ifElse %eq @actual @$const.k0_to_f %accumulate passed ##1 %accumulate failed ##1

{_test_temp_neg40_c_equals_f}
_pass = ##4
; -40 is where Celsius and Fahrenheit are equal
actual = %convertUnit #-40 "C" "F"
_ = %ifElse %eq @actual @$const.neg40_c_to_f %accumulate passed ##1 %accumulate failed ##1

{_test_temp_same_unit}
_pass = ##4
actual = %convertUnit @$const.v25 "C" "C"
_ = %ifElse %eq @actual @$const.v25 %accumulate passed ##1 %accumulate failed ##1

; ============================================================
; SPEED CONVERSIONS (mps, kph, mph)
; ============================================================

{_test_speed_kph_to_mph}
_pass = ##5
actual = %convertUnit @$const.v100 "kph" "mph"
_ = %ifElse %eq @actual @$const.kph100_to_mph %accumulate passed ##1 %accumulate failed ##1

{_test_speed_kph_to_mps}
_pass = ##5
actual = %convertUnit @$const.v100 "kph" "mps"
_ = %ifElse %eq @actual @$const.kph100_to_mps %accumulate passed ##1 %accumulate failed ##1

{_test_speed_mph_to_kph}
_pass = ##5
actual = %convertUnit #60 "mph" "kph"
_ = %ifElse %eq @actual @$const.mph60_to_kph %accumulate passed ##1 %accumulate failed ##1

; ============================================================
; AREA CONVERSIONS (sqm, sqft, sqkm, sqmi, acre, hectare)
; ============================================================

{_test_area_acre_to_sqm}
_pass = ##6
actual = %convertUnit @$const.v1 "acre" "sqm"
_ = %ifElse %eq @actual @$const.acre1_to_sqm %accumulate passed ##1 %accumulate failed ##1

{_test_area_acre_to_hectare}
_pass = ##6
actual = %convertUnit @$const.v1 "acre" "hectare"
_ = %ifElse %eq @actual @$const.acre1_to_hectare %accumulate passed ##1 %accumulate failed ##1

{_test_area_sqkm_to_sqmi}
_pass = ##6
actual = %convertUnit @$const.v1 "sqkm" "sqmi"
_ = %ifElse %eq @actual @$const.sqkm1_to_sqmi %accumulate passed ##1 %accumulate failed ##1

{_test_area_sqkm_to_hectare}
_pass = ##6
actual = %convertUnit @$const.v1 "sqkm" "hectare"
_ = %ifElse %eq @actual @$const.sqkm1_to_hectare %accumulate passed ##1 %accumulate failed ##1

; ============================================================
; DATA CONVERSIONS (B, KB, MB, GB, TB)
; ============================================================

{_test_data_gb_to_mb}
_pass = ##7
actual = %convertUnit @$const.v1 "GB" "MB"
_ = %ifElse %eq @actual @$const.gb1_to_mb %accumulate passed ##1 %accumulate failed ##1

{_test_data_gb_to_kb}
_pass = ##7
actual = %convertUnit @$const.v1 "GB" "KB"
_ = %ifElse %eq @actual @$const.gb1_to_kb %accumulate passed ##1 %accumulate failed ##1

{_test_data_gb_to_b}
_pass = ##7
actual = %convertUnit @$const.v1 "GB" "B"
_ = %ifElse %eq @actual @$const.gb1_to_b %accumulate passed ##1 %accumulate failed ##1

{_test_data_gb_to_tb}
_pass = ##7
actual = %convertUnit @$const.v1 "GB" "TB"
_ = %ifElse %eq @actual @$const.gb1_to_tb %accumulate passed ##1 %accumulate failed ##1

{_test_data_2048mb_to_gb}
_pass = ##7
actual = %convertUnit #2048 "MB" "GB"
_ = %ifElse %eq @actual @$const.mb2048_to_gb %accumulate passed ##1 %accumulate failed ##1

; ============================================================
; TIME CONVERSIONS (ms, s, min, hr, day)
; ============================================================

{_test_time_hr_to_min}
_pass = ##8
actual = %convertUnit @$const.v1 "hr" "min"
_ = %ifElse %eq @actual @$const.hr1_to_min %accumulate passed ##1 %accumulate failed ##1

{_test_time_hr_to_s}
_pass = ##8
actual = %convertUnit @$const.v1 "hr" "s"
_ = %ifElse %eq @actual @$const.hr1_to_s %accumulate passed ##1 %accumulate failed ##1

{_test_time_hr_to_ms}
_pass = ##8
actual = %convertUnit @$const.v1 "hr" "ms"
_ = %ifElse %eq @actual @$const.hr1_to_ms %accumulate passed ##1 %accumulate failed ##1

{_test_time_day_to_hr}
_pass = ##8
actual = %convertUnit @$const.v1 "day" "hr"
_ = %ifElse %eq @actual @$const.day1_to_hr %accumulate passed ##1 %accumulate failed ##1

{_test_time_day_to_min}
_pass = ##8
actual = %convertUnit @$const.v1 "day" "min"
_ = %ifElse %eq @actual @$const.day1_to_min %accumulate passed ##1 %accumulate failed ##1

; ============================================================
; EDGE CASES
; ============================================================

{_test_zero_conversion}
_pass = ##9
actual = %convertUnit @$const.v0 "kg" "lb"
_ = %ifElse %eq @actual @$const.v0 %accumulate passed ##1 %accumulate failed ##1

{_test_same_unit_identity}
_pass = ##9
actual = %convertUnit @$const.v25 "m" "m"
_ = %ifElse %eq @actual @$const.v25 %accumulate passed ##1 %accumulate failed ##1

; ============================================================
; TEST RESULT OUTPUT
; ============================================================
{TestResult}
verb = "convertUnit"
passed = "@$accumulator.passed"
failed = "@$accumulator.failed"
total = %add @$accumulator.passed @$accumulator.failed
success = %eq @$accumulator.failed ##0
