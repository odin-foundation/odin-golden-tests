{$}
odin = "1.0.0"
transform = "1.0.0"
direction = "json->json"

; ============================================================
; MULTI-KEY LOOKUP SELF-TEST
; Tests: Lookup tables with 3 or more matching columns
; Verifies: Multi-column matching, rate tables, territory tables
; ============================================================

{$const}
; === TEST INPUT VALUES ===
vehicle_type = "sedan"
coverage_type = "liability"
state = "TX"
zip_prefix = "787"
age_range = "25-35"

{$accumulator}
passed = ##0
failed = ##0

; === 3-COLUMN LOOKUP TABLE (Rate by vehicle + coverage + state) ===
{$table.RATE_3COL[vehicle, coverage, state, base_rate, factor]}
"sedan", "liability", "TX", ##250, #1.15
"sedan", "liability", "CA", ##300, #1.25
"sedan", "collision", "TX", ##175, #1.10
"sedan", "collision", "CA", ##200, #1.20
"truck", "liability", "TX", ##300, #1.20
"truck", "liability", "CA", ##350, #1.30
"truck", "collision", "TX", ##225, #1.15
"truck", "collision", "CA", ##275, #1.25

; === 4-COLUMN LOOKUP TABLE (Rate by vehicle + coverage + state + age) ===
{$table.RATE_4COL[vehicle, coverage, state, age, rate]}
"sedan", "liability", "TX", "18-24", ##400
"sedan", "liability", "TX", "25-35", ##250
"sedan", "liability", "TX", "36-50", ##200
"sedan", "liability", "CA", "18-24", ##450
"sedan", "liability", "CA", "25-35", ##300
"sedan", "liability", "CA", "36-50", ##225
"truck", "collision", "TX", "25-35", ##275
"truck", "collision", "CA", "25-35", ##325

; === TERRITORY TABLE (4-column matching) ===
{$table.TERRITORY[state, zip_prefix, territory, region]}
"TX", "787", "AUSTIN", "CENTRAL"
"TX", "750", "DALLAS", "NORTH"
"TX", "761", "FTWORTH", "NORTH"
"CA", "900", "LA", "SOUTH"
"CA", "941", "SF", "NORTH"

; ============================================================
; PASS 1: 3-COLUMN LOOKUP TESTS
; ============================================================

{_test_3col_lookup_base_rate}
_pass = ##1
; Lookup base_rate where vehicle=sedan, coverage=liability, state=TX
actual = %lookup RATE_3COL.base_rate @$const.vehicle_type @$const.coverage_type @$const.state
expected = ##250
_ = %ifElse %eq @actual @expected %accumulate passed ##1 %accumulate failed ##1

{_test_3col_lookup_factor}
_pass = ##1
; Lookup factor where vehicle=sedan, coverage=liability, state=TX
actual = %lookup RATE_3COL.factor @$const.vehicle_type @$const.coverage_type @$const.state
expected = #1.15
_ = %ifElse %eq @actual @expected %accumulate passed ##1 %accumulate failed ##1

{_test_3col_lookup_different_state}
_pass = ##1
; Lookup base_rate where vehicle=sedan, coverage=liability, state=CA
actual = %lookup RATE_3COL.base_rate @$const.vehicle_type @$const.coverage_type "CA"
expected = ##300
_ = %ifElse %eq @actual @expected %accumulate passed ##1 %accumulate failed ##1

{_test_3col_lookup_truck}
_pass = ##1
; Lookup base_rate where vehicle=truck, coverage=liability, state=TX
actual = %lookup RATE_3COL.base_rate "truck" @$const.coverage_type @$const.state
expected = ##300
_ = %ifElse %eq @actual @expected %accumulate passed ##1 %accumulate failed ##1

{_test_3col_lookup_not_found}
_pass = ##1
; Lookup with no match should return null
actual = %lookup RATE_3COL.base_rate "suv" @$const.coverage_type @$const.state
isNull = %isNull @actual
_ = %ifElse @isNull %accumulate passed ##1 %accumulate failed ##1

; ============================================================
; PASS 2: 4-COLUMN LOOKUP TESTS
; ============================================================

{_test_4col_lookup_full_match}
_pass = ##2
; Lookup rate where vehicle=sedan, coverage=liability, state=TX, age=25-35
actual = %lookup RATE_4COL.rate @$const.vehicle_type @$const.coverage_type @$const.state @$const.age_range
expected = ##250
_ = %ifElse %eq @actual @expected %accumulate passed ##1 %accumulate failed ##1

{_test_4col_lookup_young_driver}
_pass = ##2
; Lookup rate for young driver (18-24) - higher rate
actual = %lookup RATE_4COL.rate @$const.vehicle_type @$const.coverage_type @$const.state "18-24"
expected = ##400
_ = %ifElse %eq @actual @expected %accumulate passed ##1 %accumulate failed ##1

{_test_4col_lookup_older_driver}
_pass = ##2
; Lookup rate for older driver (36-50) - lower rate
actual = %lookup RATE_4COL.rate @$const.vehicle_type @$const.coverage_type @$const.state "36-50"
expected = ##200
_ = %ifElse %eq @actual @expected %accumulate passed ##1 %accumulate failed ##1

{_test_4col_lookup_different_state}
_pass = ##2
; Lookup rate in CA - higher than TX
actual = %lookup RATE_4COL.rate @$const.vehicle_type @$const.coverage_type "CA" @$const.age_range
expected = ##300
_ = %ifElse %eq @actual @expected %accumulate passed ##1 %accumulate failed ##1

; ============================================================
; PASS 3: TERRITORY LOOKUP TESTS (2-column key, 2 result columns)
; ============================================================

{_test_territory_lookup_territory}
_pass = ##3
; Lookup territory where state=TX, zip_prefix=787
actual = %lookup TERRITORY.territory @$const.state @$const.zip_prefix
expected = "AUSTIN"
_ = %ifElse %eq @actual @expected %accumulate passed ##1 %accumulate failed ##1

{_test_territory_lookup_region}
_pass = ##3
; Lookup region where state=TX, zip_prefix=787
actual = %lookup TERRITORY.region @$const.state @$const.zip_prefix
expected = "CENTRAL"
_ = %ifElse %eq @actual @expected %accumulate passed ##1 %accumulate failed ##1

{_test_territory_lookup_dallas}
_pass = ##3
; Lookup territory for Dallas
actual = %lookup TERRITORY.territory "TX" "750"
expected = "DALLAS"
_ = %ifElse %eq @actual @expected %accumulate passed ##1 %accumulate failed ##1

{_test_territory_lookup_ca}
_pass = ##3
; Lookup territory in California
actual = %lookup TERRITORY.territory "CA" "900"
expected = "LA"
_ = %ifElse %eq @actual @expected %accumulate passed ##1 %accumulate failed ##1

; ============================================================
; PASS 4: LOOKUPDEFAULT WITH MULTI-KEY
; ============================================================

{_test_3col_lookupDefault_found}
_pass = ##4
; lookupDefault with match should return matched value
actual = %lookupDefault RATE_3COL.base_rate ##999 @$const.vehicle_type @$const.coverage_type @$const.state
expected = ##250
_ = %ifElse %eq @actual @expected %accumulate passed ##1 %accumulate failed ##1

{_test_3col_lookupDefault_not_found}
_pass = ##4
; lookupDefault with no match should return default
actual = %lookupDefault RATE_3COL.base_rate ##999 "suv" @$const.coverage_type @$const.state
expected = ##999
_ = %ifElse %eq @actual @expected %accumulate passed ##1 %accumulate failed ##1

{_test_4col_lookupDefault}
_pass = ##4
; 4-column lookupDefault
actual = %lookupDefault RATE_4COL.rate ##500 "motorcycle" @$const.coverage_type @$const.state @$const.age_range
expected = ##500
_ = %ifElse %eq @actual @expected %accumulate passed ##1 %accumulate failed ##1

; ============================================================
; PASS 5: EDGE CASES - Null keys, partial matches
; ============================================================

{_test_lookup_with_null_key}
_pass = ##5
; Lookup with null key should return null (no match)
actual = %lookup RATE_3COL.base_rate ~ @$const.coverage_type @$const.state
isNull = %isNull @actual
_ = %ifElse @isNull %accumulate passed ##1 %accumulate failed ##1

{_test_lookup_empty_string_key}
_pass = ##5
; Lookup with empty string key should return null (no match)
actual = %lookup RATE_3COL.base_rate "" @$const.coverage_type @$const.state
isNull = %isNull @actual
_ = %ifElse @isNull %accumulate passed ##1 %accumulate failed ##1

{_test_4col_partial_match_fails}
_pass = ##5
; 4-column lookup with only 3 matching columns should fail (no partial match)
; Using age "99-99" which doesn't exist
actual = %lookup RATE_4COL.rate @$const.vehicle_type @$const.coverage_type @$const.state "99-99"
isNull = %isNull @actual
_ = %ifElse @isNull %accumulate passed ##1 %accumulate failed ##1

{_test_territory_nonexistent_zip}
_pass = ##5
; Territory lookup with non-existent zip should return null
actual = %lookup TERRITORY.territory "TX" "999"
isNull = %isNull @actual
_ = %ifElse @isNull %accumulate passed ##1 %accumulate failed ##1

; ============================================================
; PASS 6: LOOKUPDEFAULT EDGE CASES
; ============================================================

{_test_lookupDefault_null_key}
_pass = ##6
; lookupDefault with null key should return default
actual = %lookupDefault RATE_3COL.base_rate ##-1 ~ @$const.coverage_type @$const.state
expected = ##-1
_ = %ifElse %eq @actual @expected %accumulate passed ##1 %accumulate failed ##1

{_test_lookupDefault_all_keys_wrong}
_pass = ##6
; lookupDefault with all wrong keys should return default
actual = %lookupDefault RATE_3COL.base_rate ##999 "invalid" "invalid" "invalid"
expected = ##999
_ = %ifElse %eq @actual @expected %accumulate passed ##1 %accumulate failed ##1

{_test_lookupDefault_zero_default}
_pass = ##6
; lookupDefault with zero as default (edge case - zero is valid)
actual = %lookupDefault RATE_3COL.base_rate ##0 "nonexistent" "x" "y"
expected = ##0
_ = %ifElse %eq @actual @expected %accumulate passed ##1 %accumulate failed ##1

; ============================================================
; TEST RESULT OUTPUT
; ============================================================
{TestResult}
verb = "lookup-multikey"
passed = "@$accumulator.passed"
failed = "@$accumulator.failed"
total = %add @$accumulator.passed @$accumulator.failed
success = %eq @$accumulator.failed ##0
