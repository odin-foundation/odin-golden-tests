{$}
odin = "1.0.0"
transform = "1.0.0"
direction = "odin->odin"
target.format = "odin"

{$target}
onMissing = "skip"

; An absent source path under onMissing = skip yields null without an error.

{company}
name = @.name
city = @.city
region = @.region
