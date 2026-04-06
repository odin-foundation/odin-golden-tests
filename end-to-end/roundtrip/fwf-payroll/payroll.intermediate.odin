{header}
runDate = "2024-12-15"
companyName = "ACME CORP"
payPeriodType = "WEEKLY"
batchSequence = ##1
{trailer}
employeeCount = ##2
totalGross = #$7900.00
totalDeductions = #$1270.00
totalNet = #$53080.00
{employees[] : id, lastName, firstName, gender, birthDate, status, rate, payType}
##1234, "SMITH", "JOHN", "M", "1985-03-15", "FULL_TIME", #$800.00, "SALARY"
##5678, "GARCIA", "MARIA", "F", "1990-11-22", "FULL_TIME", #$725.00, "HOURLY"
{payments[] : employeeId, periodStart, periodEnd, hoursWorked, gross, deductions, net}
##1234, "2024-12-01", "2024-12-15", ##35, #$5000.00, #$8500.00, #$28500.00
##5678, "2024-12-01", "2024-12-15", ##29, #$2900.00, #$4200.00, #$24580.00
{adjustments[] : employeeId, type, description, amount}
##1234, "BONUS", "Q4 PERFORMANCE BONUS", #$500.00
