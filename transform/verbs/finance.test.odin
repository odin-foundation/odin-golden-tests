{$}
odin = "1.0.0"
transform = "1.0.0"
direction = "json->json"

; ============================================================
; COMPREHENSIVE FINANCIAL VERBS SELF-TEST
; Tests: log, ln, log10, exp, pow, sqrt, compound, discount,
;        pmt, fv, pv, std, variance, median, percentile,
;        quantile, covariance, correlation, clamp, interpolate,
;        weightedAvg, stdSample, varianceSample, mode
; ============================================================

{$const}
; === LOGARITHM TEST VALUES ===
ln_input = #2.718281828459045
ln_expected = ##1
log2_input = ##8
log2_expected = ##3
log10_input = ##1000
log10_expected = ##3

; === EXPONENTIAL TEST VALUES ===
exp_input = ##1
exp_expected = #2.718281828459045

; === POWER TEST VALUES ===
pow_base = ##2
pow_exp = ##10
pow_expected = ##1024
sqrt_input = ##16
sqrt_expected = ##4

; === COMPOUND INTEREST TEST VALUES ===
; $10000 at 5% for 10 years
compound_principal = ##10000
compound_rate = #0.05
compound_periods = ##10
compound_expected = #16288.946267774418

; === DISCOUNT (PV) TEST VALUES ===
discount_fv = #16288.946267774418
discount_rate = #0.05
discount_periods = ##10
discount_expected = ##10000

; === PMT TEST VALUES ===
; $10000 loan at 5% for 12 periods
pmt_principal = ##10000
pmt_rate = #0.05
pmt_periods = ##12
pmt_expected = #1128.2541040034891

; === FV ANNUITY TEST VALUES ===
; $100/period at 5% for 10 periods
fv_payment = ##100
fv_rate = #0.05
fv_periods = ##10
fv_expected = #1257.7892535308356

; === PV ANNUITY TEST VALUES ===
pv_payment = ##100
pv_rate = #0.05
pv_periods = ##10
pv_expected = #772.1734929184818

; === STATISTICAL VALUES ===
; Population std dev = 2 for [2,4,4,4,5,5,7,9]
std_expected = ##2
stdSample_expected = #2.138089935299395
variance_expected = ##4
varianceSample_expected = #4.571428571428571

; === MEDIAN VALUES ===
median_odd_expected = ##5
median_even_expected = #2.5

; === MODE TEST ===
mode_expected = ##3

; === PERCENTILE VALUES ===
percentile50_expected = #5.5
percentile90_expected = #9.1

; === QUANTILE VALUES ===
quantile75_expected = #7.75

; === COVARIANCE TEST ===
; Arrays [1,2,3,4,5] and [2,4,6,8,10] have cov = 4
covariance_expected = ##4
correlation_expected = ##1

; === CLAMP TEST VALUES ===
clamp_in_range = ##50
clamp_below_min = ##-10
clamp_above_max = ##150
clamp_min = ##0
clamp_max = ##100

; === INTERPOLATE TEST VALUES ===
; x=35 between (25,100) and (45,200) = 150
interp_x = ##35
interp_x1 = ##25
interp_y1 = ##100
interp_x2 = ##45
interp_y2 = ##200
interp_expected = ##150

; === WEIGHTED AVERAGE VALUES ===
; [80,90,100] with weights [1,2,1] = 90
weightedAvg_expected = ##90

{$accumulator}
passed = ##0
failed = ##0

; ============================================================
; PASS 1: LOGARITHM AND EXPONENTIAL TESTS
; ============================================================

{_test_ln}
_pass = ##1
actual = %round %ln @$const.ln_input ##0
_ = %ifElse %eq @actual @$const.ln_expected %accumulate passed ##1 %accumulate failed ##1

{_test_log2}
_pass = ##1
actual = %round %log @$const.log2_input ##2 ##0
_ = %ifElse %eq @actual @$const.log2_expected %accumulate passed ##1 %accumulate failed ##1

{_test_log10}
_pass = ##1
actual = %round %log10 @$const.log10_input ##0
_ = %ifElse %eq @actual @$const.log10_expected %accumulate passed ##1 %accumulate failed ##1

{_test_exp}
_pass = ##1
actual = %exp @$const.exp_input
_ = %ifElse %eq @actual @$const.exp_expected %accumulate passed ##1 %accumulate failed ##1

; ============================================================
; PASS 2: POWER AND ROOT TESTS
; ============================================================

{_test_pow}
_pass = ##2
actual = %pow @$const.pow_base @$const.pow_exp
_ = %ifElse %eq @actual @$const.pow_expected %accumulate passed ##1 %accumulate failed ##1

{_test_sqrt}
_pass = ##2
actual = %sqrt @$const.sqrt_input
_ = %ifElse %eq @actual @$const.sqrt_expected %accumulate passed ##1 %accumulate failed ##1

; sqrt(x)^2 should equal x (round-trip verification)
{_test_sqrt_roundtrip}
_pass = ##2
sqrtVal = %sqrt @$const.sqrt_input
actual = %pow @sqrtVal ##2
_ = %ifElse %eq @actual @$const.sqrt_input %accumulate passed ##1 %accumulate failed ##1

; ============================================================
; PASS 3: TIME VALUE OF MONEY TESTS
; ============================================================

{_test_compound}
_pass = ##3
actual = %compound @$const.compound_principal @$const.compound_rate @$const.compound_periods
_ = %ifElse %eq @actual @$const.compound_expected %accumulate passed ##1 %accumulate failed ##1

{_test_discount}
_pass = ##3
actual = %round %discount @$const.discount_fv @$const.discount_rate @$const.discount_periods ##0
_ = %ifElse %eq @actual @$const.discount_expected %accumulate passed ##1 %accumulate failed ##1

{_test_pmt}
_pass = ##3
actual = %pmt @$const.pmt_principal @$const.pmt_rate @$const.pmt_periods
_ = %ifElse %eq @actual @$const.pmt_expected %accumulate passed ##1 %accumulate failed ##1

{_test_fv}
_pass = ##3
actual = %fv @$const.fv_payment @$const.fv_rate @$const.fv_periods
_ = %ifElse %eq @actual @$const.fv_expected %accumulate passed ##1 %accumulate failed ##1

{_test_pv}
_pass = ##3
actual = %pv @$const.pv_payment @$const.pv_rate @$const.pv_periods
_ = %ifElse %eq @actual @$const.pv_expected %accumulate passed ##1 %accumulate failed ##1

; compound/discount round-trip: discount(compound(P,r,n),r,n) = P
{_test_compound_discount_roundtrip}
_pass = ##3
compounded = %compound @$const.compound_principal @$const.compound_rate @$const.compound_periods
actual = %round %discount @compounded @$const.compound_rate @$const.compound_periods ##0
_ = %ifElse %eq @actual @$const.compound_principal %accumulate passed ##1 %accumulate failed ##1

; ============================================================
; PASS 4: STATISTICAL TESTS (using embedded arrays)
; ============================================================

{_internal_stats}
_pass = ##4
; Create test arrays in output for statistical operations
stdArray = "[##2, ##4, ##4, ##4, ##5, ##5, ##7, ##9]"
oddArray = "[##1, ##3, ##5, ##7, ##9]"
evenArray = "[##1, ##2, ##3, ##4]"
modeArray = "[##1, ##2, ##2, ##3, ##3, ##3, ##4]"
percArray = "[##1, ##2, ##3, ##4, ##5, ##6, ##7, ##8, ##9, ##10]"

{_test_std}
_pass = ##4
actual = %std @_internal_stats.stdArray
_ = %ifElse %eq @actual @$const.std_expected %accumulate passed ##1 %accumulate failed ##1

{_test_stdSample}
_pass = ##4
actual = %stdSample @_internal_stats.stdArray
_ = %ifElse %eq @actual @$const.stdSample_expected %accumulate passed ##1 %accumulate failed ##1

{_test_variance}
_pass = ##4
actual = %variance @_internal_stats.stdArray
_ = %ifElse %eq @actual @$const.variance_expected %accumulate passed ##1 %accumulate failed ##1

{_test_varianceSample}
_pass = ##4
actual = %varianceSample @_internal_stats.stdArray
_ = %ifElse %eq @actual @$const.varianceSample_expected %accumulate passed ##1 %accumulate failed ##1

{_test_median_odd}
_pass = ##4
actual = %median @_internal_stats.oddArray
_ = %ifElse %eq @actual @$const.median_odd_expected %accumulate passed ##1 %accumulate failed ##1

{_test_median_even}
_pass = ##4
actual = %median @_internal_stats.evenArray
_ = %ifElse %eq @actual @$const.median_even_expected %accumulate passed ##1 %accumulate failed ##1

{_test_mode}
_pass = ##4
actual = %mode @_internal_stats.modeArray
_ = %ifElse %eq @actual @$const.mode_expected %accumulate passed ##1 %accumulate failed ##1

; ============================================================
; PASS 5: PERCENTILE, QUANTILE, AND CORRELATION TESTS
; ============================================================

{_test_percentile50}
_pass = ##5
actual = %percentile @_internal_stats.percArray ##50
_ = %ifElse %eq @actual @$const.percentile50_expected %accumulate passed ##1 %accumulate failed ##1

{_test_percentile90}
_pass = ##5
actual = %percentile @_internal_stats.percArray ##90
_ = %ifElse %eq @actual @$const.percentile90_expected %accumulate passed ##1 %accumulate failed ##1

{_test_quantile75}
_pass = ##5
actual = %quantile @_internal_stats.percArray #0.75
_ = %ifElse %eq @actual @$const.quantile75_expected %accumulate passed ##1 %accumulate failed ##1

{_internal_corr}
_pass = ##5
arr1 = "[##1, ##2, ##3, ##4, ##5]"
arr2 = "[##2, ##4, ##6, ##8, ##10]"

{_test_covariance}
_pass = ##5
actual = %covariance @_internal_corr.arr1 @_internal_corr.arr2
_ = %ifElse %eq @actual @$const.covariance_expected %accumulate passed ##1 %accumulate failed ##1

{_test_correlation}
_pass = ##5
actual = %correlation @_internal_corr.arr1 @_internal_corr.arr2
_ = %ifElse %eq @actual @$const.correlation_expected %accumulate passed ##1 %accumulate failed ##1

; ============================================================
; PASS 6: CLAMP, INTERPOLATE, AND WEIGHTED AVERAGE TESTS
; ============================================================

{_test_clamp_in_range}
_pass = ##6
actual = %clamp @$const.clamp_in_range @$const.clamp_min @$const.clamp_max
_ = %ifElse %eq @actual @$const.clamp_in_range %accumulate passed ##1 %accumulate failed ##1

{_test_clamp_below}
_pass = ##6
actual = %clamp @$const.clamp_below_min @$const.clamp_min @$const.clamp_max
_ = %ifElse %eq @actual @$const.clamp_min %accumulate passed ##1 %accumulate failed ##1

{_test_clamp_above}
_pass = ##6
actual = %clamp @$const.clamp_above_max @$const.clamp_min @$const.clamp_max
_ = %ifElse %eq @actual @$const.clamp_max %accumulate passed ##1 %accumulate failed ##1

{_test_interpolate}
_pass = ##6
actual = %interpolate @$const.interp_x @$const.interp_x1 @$const.interp_y1 @$const.interp_x2 @$const.interp_y2
_ = %ifElse %eq @actual @$const.interp_expected %accumulate passed ##1 %accumulate failed ##1

{_internal_weighted}
_pass = ##6
values = "[##80, ##90, ##100]"
weights = "[##1, ##2, ##1]"

{_test_weightedAvg}
_pass = ##6
actual = %weightedAvg @_internal_weighted.values @_internal_weighted.weights
_ = %ifElse %eq @actual @$const.weightedAvg_expected %accumulate passed ##1 %accumulate failed ##1

; ============================================================
; TEST RESULT OUTPUT
; ============================================================
{TestResult}
verb = "finance"
passed = "@$accumulator.passed"
failed = "@$accumulator.failed"
total = %add @$accumulator.passed @$accumulator.failed
success = %eq @$accumulator.failed ##0
