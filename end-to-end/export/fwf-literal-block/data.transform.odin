{$}
odin = "1.0.0"
transform = "1.0.0"
direction = "odin->fixed-width"
target.format = "fixed-width"
description = "Literal blocks with ${...} interpolation, escapes, loop, and verb"

{HDR}
:literal
"""
HDR|${@policy.number}|${%upper @policy.code}
"""

{DET[]}
:loop @items
:literal
"""
DET|${@.sku}|${@.qty}
"""

{NOTE}
:literal
"""
NOTE|literal:\${@policy.number} dollar:\$ value:${@policy.number}
"""
