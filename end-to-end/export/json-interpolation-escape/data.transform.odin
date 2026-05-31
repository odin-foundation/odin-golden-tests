{$}
odin = "1.0.0"
transform = "1.0.0"
direction = "odin->json"

{$source}
format = "odin"

{$target}
format = "json"
indent = ##2

{Receipt}
price = "Total: \$${@.amount}"
template = "Use \${@.field} for the value"
name = "${@.name}"
