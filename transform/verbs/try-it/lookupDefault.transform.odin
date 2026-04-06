{$}
odin = "1.0.0"
transform = "1.0.0"

{$table.STATUS[name, code]}
"active", "A"
"pending", "P"
"cancelled", "C"

{}
statusCode = %lookupDefault "STATUS.code" "X" @.status
