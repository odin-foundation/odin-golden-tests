{$}
odin = "1.0.0"
transform = "1.0.0"
direction = "json->odin"
target.format = "odin"
description = "Transform JSON array with recordType discriminator to structured ODIN"

; For JSON records, use direct path access since records are pre-filtered
{$source}
format = "json"

; Extract policy from the first POLICY record (index-based access)
{policy}
number = @records[0].policyNumber
effective = @records[0].effectiveDate :date
term_months = @records[0].termMonths :type integer
premium = @records[0].premium :type currency

; VEHICLE records at indices 1-2
{vehicles[0]}
vin = @records[1].vin
year = @records[1].year :type integer
make = @records[1].make
model = @records[1].model

{vehicles[1]}
vin = @records[2].vin
year = @records[2].year :type integer
make = @records[2].make
model = @records[2].model

; DRIVER records at indices 3-4
{drivers[0]}
name.first = @records[3].firstName
name.last = @records[3].lastName
license.number = @records[3].licenseNumber
license.state = @records[3].licenseState
dob = @records[3].dateOfBirth :date
primary = @records[3].isPrimary :type boolean

{drivers[1]}
name.first = @records[4].firstName
name.last = @records[4].lastName
license.number = @records[4].licenseNumber
license.state = @records[4].licenseState
dob = @records[4].dateOfBirth :date
primary = @records[4].isPrimary :type boolean

; COVERAGE records at indices 5-7
{coverages[0]}
type = @records[5].type
limit = @records[5].limit :type integer
premium = @records[5].premium :type currency

{coverages[1]}
type = @records[6].type
deductible = @records[6].deductible :type integer
premium = @records[6].premium :type currency

{coverages[2]}
type = @records[7].type
deductible = @records[7].deductible :type integer
premium = @records[7].premium :type currency
