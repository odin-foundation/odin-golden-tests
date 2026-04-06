{$}
odin = "1.0.0"
transform = "1.0.0"
direction = "fixed-width->odin"
target.format = "odin"
description = "Import ACME Payroll Export (APE) fixed-width to ODIN"

{$source}
format = "fixed-width"
discriminator = ":pos 0 :len 3"

{$.table.employeeStatus[code, label]}
"FT", "FULL_TIME"
"PT", "PART_TIME"
"CT", "CONTRACTOR"

; ═══════════════════════════════════════════════════════════════════════════════
; HDR - Header Record (44 chars)
; Pos 0-2: Type, 3-10: Date, 11-30: Company, 31-40: PayPeriod, 41-43: Batch
; ═══════════════════════════════════════════════════════════════════════════════

{header}
_type = "HDR"
runDate = %parseDate @_line :pos 3 :len 8 "YYYYMMDD"
companyName = @_line :pos 11 :len 20 :trim
payPeriodType = @_line :pos 31 :len 10 :trim
batchSequence = %coerceInteger @_line :pos 41 :len 3

; ═══════════════════════════════════════════════════════════════════════════════
; EMP - Employee Record (69 chars)
; Pos 0-2: Type, 3-8: ID, 9-28: LastName, 29-48: FirstName, 49: Gender,
;     50-57: BirthDate, 58-59: Status, 60-65: Rate (implied 2 dec), 66-68: PayType
; ═══════════════════════════════════════════════════════════════════════════════

{employees[]}
_type = "EMP"
id = %coerceInteger @_line :pos 3 :len 6
lastName = @_line :pos 9 :len 20 :trim
firstName = @_line :pos 29 :len 20 :trim
gender = @_line :pos 49 :len 1
birthDate = %parseDate @_line :pos 50 :len 8 "YYYYMMDD"
status = %lookupDefault "employeeStatus.label" @_line :pos 58 :len 2 "UNKNOWN"
rate = %divide %coerceNumber @_line :pos 60 :len 6 ##100 :type currency
payType = %switch @_line :pos 66 :len 3 :trim "SAL" "SALARY" "HRL" "HOURLY" "UNKNOWN"

; ═══════════════════════════════════════════════════════════════════════════════
; PAY - Payment Record (57 chars)
; Pos 0-2: Type, 3-8: EmpID, 9-16: Start, 17-24: End, 25-26: Hours,
;     27-36: Gross (implied 2 dec), 37-46: Deductions, 47-56: Net
; ═══════════════════════════════════════════════════════════════════════════════

{payments[]}
_type = "PAY"
employeeId = %coerceInteger @_line :pos 3 :len 6
periodStart = %parseDate @_line :pos 9 :len 8 "YYYYMMDD"
periodEnd = %parseDate @_line :pos 17 :len 8 "YYYYMMDD"
hoursWorked = %coerceInteger @_line :pos 25 :len 2
gross = %divide %coerceNumber @_line :pos 27 :len 10 ##100 :type currency
deductions = %divide %coerceNumber @_line :pos 37 :len 10 ##100 :type currency
net = %divide %coerceNumber @_line :pos 47 :len 10 ##100 :type currency

; ═══════════════════════════════════════════════════════════════════════════════
; ADJ - Adjustment Record (54 chars)
; Pos 0-2: Type, 3-8: EmpID, 9-13: AdjType, 14-43: Description, 44-53: Amount
; ═══════════════════════════════════════════════════════════════════════════════

{adjustments[]}
_type = "ADJ"
employeeId = %coerceInteger @_line :pos 3 :len 6
type = @_line :pos 9 :len 5 :trim
description = @_line :pos 14 :len 30 :trim
amount = %divide %coerceNumber @_line :pos 44 :len 10 ##100 :type currency

; ═══════════════════════════════════════════════════════════════════════════════
; TRL - Trailer Record (39 chars)
; Pos 0-2: Type, 3-8: Count, 9-18: TotalGross, 19-28: TotalDed, 29-38: TotalNet
; ═══════════════════════════════════════════════════════════════════════════════

{trailer}
_type = "TRL"
employeeCount = %coerceInteger @_line :pos 3 :len 6
totalGross = %divide %coerceNumber @_line :pos 9 :len 10 ##100 :type currency
totalDeductions = %divide %coerceNumber @_line :pos 19 :len 10 ##100 :type currency
totalNet = %divide %coerceNumber @_line :pos 29 :len 10 ##100 :type currency
