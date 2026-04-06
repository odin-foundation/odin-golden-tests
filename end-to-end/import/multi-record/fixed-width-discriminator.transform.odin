{$}
odin = "1.0.0"
transform = "1.0.0"
direction = "fixed-width->odin"
target.format = "odin"
description = "Transform multi-record fixed-width file using position-based discriminator"

; Position-based discriminator: first 2 characters identify record type
{$source}
format = "fixed-width"
discriminator = ":pos 0 :len 2"

; Lookup table for status codes
{$.table.STATUS[code, name]}
"A", "Active"
"P", "Pending"
"C", "Cancelled"
"X", "Expired"

; Record type 01: Policy header
{policy}
_type = "01"
number = @_line :pos 2 :len 15 :trim
effective = %parseDate @_line :pos 17 :len 8 "MMDDYYYY"
term = @_line :pos 25 :len 3 :trim
status = %lookupDefault "STATUS.name" @_line :pos 28 :len 1 "Unknown"

; Record type 20: Vehicle records
{vehicles[]}
_type = "20"
vin = @_line :pos 2 :len 17 :trim
year = @_line :pos 19 :len 4 :type integer
make = @_line :pos 23 :len 5 :trim
model = @_line :pos 28 :len 10 :trim
usage = %lower @_line :pos 38 :len 8 :trim

; Record type 30: Driver records
{drivers[]}
_type = "30"
name.first = @_line :pos 2 :len 15 :trim
name.last = @_line :pos 17 :len 15 :trim
license.number = @_line :pos 32 :len 12 :trim
license.state = @_line :pos 44 :len 2
dob = %parseDate @_line :pos 46 :len 8 "YYYYMMDD"

; Record type 99: Trailer/Summary (for validation)
{summary}
_type = "99"
label = @_line :pos 2 :len 15 :trim
vehicle_count = @_line :pos 17 :len 4 :type integer
driver_count = @_line :pos 25 :len 4 :type integer
total_premium = @_line :pos 33 :len 10 :type currency :trim
