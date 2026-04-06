{$}
odin = "1.0.0"
transform = "1.0.0"
direction = "json->json"

; ============================================================
; ADVANCED FINANCIAL VERBS SELF-TEST
; Tests: npv, irr, rate, nper, depreciation
; These complement finance.test.odin for remaining financial verbs
; ============================================================

{$const}
; === NPV TEST VALUES ===
; NPV at 10% for cash flows [-1000, 200, 300, 400, 500]
; Exact: -1000 + 200/1.1 + 300/1.21 + 400/1.331 + 500/1.4641 = 78.82...
npv_rate = #0.10
npv_expected = #78.82
npv_tolerance = #0.01

; === IRR TEST VALUES ===
; IRR for [-1000, 400, 400, 400]
; Solve: -1000 + 400/(1+r) + 400/(1+r)^2 + 400/(1+r)^3 = 0
; Exact IRR = 0.09701... (~9.70%)
irr_expected = #0.0970
irr_tolerance = #0.001

; === RATE TEST VALUES ===
; Rate to turn $1000 into $1500 over 5 periods
; Formula: (FV/PV)^(1/n) - 1 = (1500/1000)^(1/5) - 1
; Exact: 0.08447177... (~8.447%)
rate_pv = ##1000
rate_fv = ##1500
rate_periods = ##5
rate_expected = #0.08447
rate_tolerance = #0.0001

; === NPER TEST VALUES ===
; Periods to double money at 7.2%
; Formula: ln(FV/PV) / ln(1+r) = ln(2) / ln(1.072)
; Exact: 9.9693... periods
nper_rate = #0.072
nper_pv = ##1000
nper_fv = ##2000
nper_expected = #9.9693
nper_tolerance = #0.01

; === DEPRECIATION TEST VALUES ===
; Straight-line depreciation: $10000 asset, $1000 salvage, 5 years
; Annual depreciation = (10000-1000)/5 = 1800 (exact)
depreciation_cost = ##10000
depreciation_salvage = ##1000
depreciation_life = ##5
depreciation_expected = ##1800

{$accumulator}
passed = ##0
failed = ##0

; ============================================================
; PASS 1: NPV TESTS
; ============================================================

{_internal_npv}
_pass = ##1
; Cash flows: initial investment (-1000) + future returns
cashflows = "[##-1000, ##200, ##300, ##400, ##500]"

{_test_npv_calculation}
_pass = ##1
; NPV should be calculated correctly: ~78.82
actual = %npv @$const.npv_rate @_internal_npv.cashflows
diff = %abs %subtract @actual @$const.npv_expected
withinTolerance = %lte @diff @$const.npv_tolerance
_ = %ifElse @withinTolerance %accumulate passed ##1 %accumulate failed ##1

{_test_npv_type}
_pass = ##1
actual = %npv @$const.npv_rate @_internal_npv.cashflows
; Result should be a number
isNum = %isNumber @actual
_ = %ifElse @isNum %accumulate passed ##1 %accumulate failed ##1

; ============================================================
; PASS 2: IRR TESTS
; ============================================================

{_internal_irr}
_pass = ##2
; Cash flows for IRR calculation
cashflows = "[##-1000, ##400, ##400, ##400]"

{_test_irr_calculation}
_pass = ##2
; IRR should be ~9.70%
actual = %irr @_internal_irr.cashflows
diff = %abs %subtract @actual @$const.irr_expected
withinTolerance = %lte @diff @$const.irr_tolerance
_ = %ifElse @withinTolerance %accumulate passed ##1 %accumulate failed ##1

{_test_irr_type}
_pass = ##2
; IRR result should be a number
actual = %irr @_internal_irr.cashflows
isNum = %isNumber @actual
_ = %ifElse @isNum %accumulate passed ##1 %accumulate failed ##1

; ============================================================
; PASS 3: RATE TESTS
; ============================================================

{_test_rate_calculation}
_pass = ##3
; Calculate rate to grow $1000 to $1500 in 5 periods: ~8.447%
actual = %rate @$const.rate_periods ##0 @$const.rate_pv @$const.rate_fv
diff = %abs %subtract @actual @$const.rate_expected
withinTolerance = %lte @diff @$const.rate_tolerance
_ = %ifElse @withinTolerance %accumulate passed ##1 %accumulate failed ##1

{_test_rate_type}
_pass = ##3
; Rate result should be a number
actual = %rate @$const.rate_periods ##0 @$const.rate_pv @$const.rate_fv
isNum = %isNumber @actual
_ = %ifElse @isNum %accumulate passed ##1 %accumulate failed ##1

; ============================================================
; PASS 4: NPER TESTS
; ============================================================

{_test_nper_calculation}
_pass = ##4
; Calculate periods to double money at 7.2%: ~9.9693 periods
actual = %nper @$const.nper_rate ##0 @$const.nper_pv @$const.nper_fv
diff = %abs %subtract @actual @$const.nper_expected
withinTolerance = %lte @diff @$const.nper_tolerance
_ = %ifElse @withinTolerance %accumulate passed ##1 %accumulate failed ##1

{_test_nper_type}
_pass = ##4
; NPER result should be a number
actual = %nper @$const.nper_rate ##0 @$const.nper_pv @$const.nper_fv
isNum = %isNumber @actual
_ = %ifElse @isNum %accumulate passed ##1 %accumulate failed ##1

; ============================================================
; PASS 5: DEPRECIATION TESTS
; ============================================================

{_test_depreciation_straightline}
_pass = ##5
; Straight-line depreciation
actual = %depreciation @$const.depreciation_cost @$const.depreciation_salvage @$const.depreciation_life
_ = %ifElse %eq @actual @$const.depreciation_expected %accumulate passed ##1 %accumulate failed ##1

{_test_depreciation_total}
_pass = ##5
; Total depreciation over life should equal cost - salvage
annual = %depreciation @$const.depreciation_cost @$const.depreciation_salvage @$const.depreciation_life
total = %multiply @annual @$const.depreciation_life
expected = %subtract @$const.depreciation_cost @$const.depreciation_salvage
_ = %ifElse %eq @total @expected %accumulate passed ##1 %accumulate failed ##1

; ============================================================
; TEST RESULT OUTPUT
; ============================================================
{TestResult}
verb = "financial-advanced"
passed = "@$accumulator.passed"
failed = "@$accumulator.failed"
total = %add @$accumulator.passed @$accumulator.failed
success = %eq @$accumulator.failed ##0
