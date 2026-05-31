{$}
odin = "1.0.0"
transform = "1.0.0"
direction = "odin->fixed-width"
target.format = "fixed-width"
description = "Records are padded to the configured lineWidth using padChar"

{$target}
lineWidth = ##20
padChar = "."

{record}
code = @record.code :pos 0 :len 5 :rightPad " "
name = @record.name :pos 5 :len 8 :rightPad " "
