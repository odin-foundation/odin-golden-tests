{$}
odin = "1.0.0"
transform = "1.0.0"
direction = "csv->odin"
target.format = "odin"
description = "Transform multi-record CSV using field-based discriminator"

; Field-based discriminator: first field identifies record type
{$source}
format = "csv"
discriminator = ":field 0"

; POLICY record type (singular - only one policy per file)
{policy}
_type = "POLICY"
number = @_line :field 1
effective = @_line :field 2 :date
term_months = @_line :field 3
premium = @_line :field 4 :type currency

; VEHICLE record type (array - multiple vehicles)
{vehicles[]}
_type = "VEHICLE"
vin = @_line :field 1
year = @_line :field 2 :type integer
make = @_line :field 3
model = @_line :field 4

; DRIVER record type (array - multiple drivers)
{drivers[]}
_type = "DRIVER"
name.first = @_line :field 1
name.last = @_line :field 2
license.number = @_line :field 3
license.state = @_line :field 4
dob = @_line :field 5 :date
primary = @_line :field 6 :type boolean

; COVERAGE record type (array - multiple coverages)
{coverages[]}
_type = "COVERAGE"
type = @_line :field 1
limit = @_line :field 2 :type integer
premium = @_line :field 3 :type currency
