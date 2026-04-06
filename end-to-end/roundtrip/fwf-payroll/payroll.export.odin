{$}
odin = "1.0.0"
transform = "1.0.0"
direction = "odin->fixed-width"
target.format = "fixed-width"
description = "Export ODIN to ACME Payroll Export (APE) fixed-width format"

{$target}
lineWidth = ##80

; ═══════════════════════════════════════════════════════════════════════════════
; HDR - Header Record (44 chars)
; Pos 0-2: Type, 3-10: Date, 11-30: Company, 31-40: PayPeriod, 41-43: Batch
; ═══════════════════════════════════════════════════════════════════════════════

{header}
_type = "HDR"
type = "HDR" :pos 0 :len 3
runDate = %formatDate @header.runDate "YYYYMMDD" :pos 3 :len 8
companyName = @header.companyName :pos 11 :len 20 :rightPad " "
payPeriodType = @header.payPeriodType :pos 31 :len 10 :rightPad " "
batchSequence = %formatNumber @header.batchSequence ##0 :pos 41 :len 3 :leftPad "0"

; ═══════════════════════════════════════════════════════════════════════════════
; EMP - Employee Record (69 chars)
; Pos 0-2: Type, 3-8: ID, 9-28: LastName, 29-48: FirstName, 49: Gender,
;     50-57: BirthDate, 58-59: Status, 60-65: Rate (implied 2 dec), 66-68: PayType
; ═══════════════════════════════════════════════════════════════════════════════

{employees[]}
_type = "EMP"
_loop = "@employees"
type = "EMP" :pos 0 :len 3
id = %formatNumber @.id ##0 :pos 3 :len 6 :leftPad "0"
lastName = @.lastName :pos 9 :len 20 :rightPad " "
firstName = @.firstName :pos 29 :len 20 :rightPad " "
gender = @.gender :pos 49 :len 1
birthDate = %formatDate @.birthDate "YYYYMMDD" :pos 50 :len 8
status = %switch @.status "FULL_TIME" "FT" "PART_TIME" "PT" "CONTRACTOR" "CT" "??" :pos 58 :len 2
rate = %formatNumber %multiply @.rate ##100 ##0 :pos 60 :len 6 :leftPad "0"
payType = %switch @.payType "SALARY" "SAL" "HOURLY" "HRL" "???" :pos 66 :len 3

; ═══════════════════════════════════════════════════════════════════════════════
; PAY - Payment Record (57 chars)
; Pos 0-2: Type, 3-8: EmpID, 9-16: Start, 17-24: End, 25-26: Hours,
;     27-36: Gross (implied 2 dec), 37-46: Deductions, 47-56: Net
; ═══════════════════════════════════════════════════════════════════════════════

{payments[]}
_type = "PAY"
_loop = "@payments"
type = "PAY" :pos 0 :len 3
employeeId = %formatNumber @.employeeId ##0 :pos 3 :len 6 :leftPad "0"
periodStart = %formatDate @.periodStart "YYYYMMDD" :pos 9 :len 8
periodEnd = %formatDate @.periodEnd "YYYYMMDD" :pos 17 :len 8
hoursWorked = %formatNumber @.hoursWorked ##0 :pos 25 :len 2 :leftPad "0"
gross = %formatNumber %multiply @.gross ##100 ##0 :pos 27 :len 10 :leftPad "0"
deductions = %formatNumber %multiply @.deductions ##100 ##0 :pos 37 :len 10 :leftPad "0"
net = %formatNumber %multiply @.net ##100 ##0 :pos 47 :len 10 :leftPad "0"

; ═══════════════════════════════════════════════════════════════════════════════
; ADJ - Adjustment Record (54 chars)
; Pos 0-2: Type, 3-8: EmpID, 9-13: AdjType, 14-43: Description, 44-53: Amount
; ═══════════════════════════════════════════════════════════════════════════════

{adjustments[]}
_type = "ADJ"
_loop = "@adjustments"
type = "ADJ" :pos 0 :len 3
employeeId = %formatNumber @.employeeId ##0 :pos 3 :len 6 :leftPad "0"
adjType = @.type :pos 9 :len 5 :rightPad " "
description = @.description :pos 14 :len 30 :rightPad " "
amount = %formatNumber %multiply @.amount ##100 ##0 :pos 44 :len 10 :leftPad "0"

; ═══════════════════════════════════════════════════════════════════════════════
; TRL - Trailer Record (39 chars)
; Pos 0-2: Type, 3-8: Count, 9-18: TotalGross, 19-28: TotalDed, 29-38: TotalNet
; ═══════════════════════════════════════════════════════════════════════════════

{trailer}
_type = "TRL"
type = "TRL" :pos 0 :len 3
employeeCount = %formatNumber @trailer.employeeCount ##0 :pos 3 :len 6 :leftPad "0"
totalGross = %formatNumber %multiply @trailer.totalGross ##100 ##0 :pos 9 :len 10 :leftPad "0"
totalDeductions = %formatNumber %multiply @trailer.totalDeductions ##100 ##0 :pos 19 :len 10 :leftPad "0"
totalNet = %formatNumber %multiply @trailer.totalNet ##100 ##0 :pos 29 :len 10 :leftPad "0"
