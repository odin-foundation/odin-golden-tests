{$}
odin = "1.0.0"
{}
{policy}
number = "POL-100"
{policy.vehicles[0]}
vin = "VIN-A"
{policy.vehicles[0].coverages[] : code, limit}
"LIAB", #$100000.00
"COLL", #$50000.00
{policy.vehicles[1]}
vin = "VIN-B"
{policy.vehicles[1].coverages[] : code, limit}
"COMP", #$25000.00
