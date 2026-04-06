{$}
odin = "1.0.0"
transform = "1.0.0"

{$table.BODY_TYPES[name, code]}
"sedan", "SD"
"coupe", "CP"
"suv", "SU"
"truck", "TK"

{}
vehicleCode = %lookup "BODY_TYPES.code" @.vehicleType
