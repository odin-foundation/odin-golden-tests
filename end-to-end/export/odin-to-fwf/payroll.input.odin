{$}
odin = "1.0.0"
{}
{header}
type = "HDR"
runDate = "2024-12-15"
companyName = "ACME CORP"
batchId = ##1
{employees[] : id, lastName, firstName, department, salary, active}
##101, "SMITH", "JOHN", "ENG", #$85000.00, true
##102, "DOE", "JANE", "MKT", #$72000.00, true
##103, "WILSON", "BOB", "ENG", #$92000.00, false
{trailer}
type = "TRL"
recordCount = ##3
totalSalary = #$249000.00
