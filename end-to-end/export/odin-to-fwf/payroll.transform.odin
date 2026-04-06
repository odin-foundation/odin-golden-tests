{$}
odin = "1.0.0"
transform = "1.0.0"
direction = "odin->fixed-width"
target.format = "fixed-width"
description = "Export ODIN payroll data to fixed-width format"

; Fixed-width format specification:
; HDR: type(0-2), date(3-10), company(11-30), batchId(31-33) = 34 chars
; EMP: type(0-2), id(3-7), lastName(8-17), firstName(18-27), dept(28-30), salary(31-38), active(39) = 40 chars
; TRL: type(0-2), count(3-7), totalSalary(8-17) = 18 chars

{header}
_type = "HDR"
type = @header.type :pos 0 :len 3
runDate = %formatDate @header.runDate "YYYYMMDD" :pos 3 :len 8
companyName = @header.companyName :pos 11 :len 20 :rightPad " "
batchId = %formatInteger @header.batchId :pos 31 :len 3 :leftPad "0"

{employees[]}
_type = "EMP"
_loop = "@employees"
type = "EMP" :pos 0 :len 3
id = %formatInteger @.id :pos 3 :len 5 :leftPad "0"
lastName = @.lastName :pos 8 :len 10 :rightPad " "
firstName = @.firstName :pos 18 :len 10 :rightPad " "
department = @.department :pos 28 :len 3
salary = %formatInteger %multiply @.salary ##100 :pos 31 :len 8 :leftPad "0"
active = %ifElse @.active "Y" "N" :pos 39 :len 1

{trailer}
_type = "TRL"
type = @trailer.type :pos 0 :len 3
recordCount = %formatInteger @trailer.recordCount :pos 3 :len 5 :leftPad "0"
totalSalary = %formatInteger %multiply @trailer.totalSalary ##100 :pos 8 :len 10 :leftPad "0"
