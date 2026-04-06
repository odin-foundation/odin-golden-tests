{$}
odin = "1.0.0"
transform = "1.0.0"
direction = "fixed-width->odin"
target.format = "odin"
description = "Import fixed-width payroll data to ODIN"

{$source}
format = "fixed-width"
discriminator = ":pos 0 :len 3"

; ═══════════════════════════════════════════════════════════════════════════════
; HDR - Header Record (44 chars)
; Pos 0-2: Type, 3-10: Date, 11-40: Company, 41-43: Version
; ═══════════════════════════════════════════════════════════════════════════════

{header}
_type = "HDR"
date = %parseDate @_line :pos 3 :len 8 "YYYYMMDD"
company = @_line :pos 11 :len 30 :trim
version = %coerceInteger @_line :pos 41 :len 3

; ═══════════════════════════════════════════════════════════════════════════════
; EMP - Employee Record (40 chars)
; Pos 0-2: Type, 3-7: EmpId, 8-17: LastName, 18-27: FirstName,
;     28-30: Dept, 31-38: Salary (implied 2 dec), 39: Active
; ═══════════════════════════════════════════════════════════════════════════════

{employees[]}
_type = "EMP"
id = %coerceInteger @_line :pos 3 :len 5
lastName = @_line :pos 8 :len 10 :trim
firstName = @_line :pos 18 :len 10 :trim
department = @_line :pos 28 :len 3 :trim
salary = %divide %coerceNumber @_line :pos 31 :len 8 ##100
active = @_line :pos 39 :len 1

; ═══════════════════════════════════════════════════════════════════════════════
; TRL - Trailer Record (17 chars)
; Pos 0-2: Type, 3-7: Count, 8-16: TotalSalary (implied 2 dec)
; ═══════════════════════════════════════════════════════════════════════════════

{trailer}
_type = "TRL"
recordCount = %coerceInteger @_line :pos 3 :len 5
totalSalary = %divide %coerceNumber @_line :pos 8 :len 9 ##100
