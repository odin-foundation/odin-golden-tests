{$}
odin = "1.0.0"
transform = "1.0.0"

{$accumulator}
subtotal = ##0

{_calcSubtotal}
_ = %accumulate subtotal %multiply @.quantity @.unitPrice

{}
item = @.item
subtotal = @$accumulator.subtotal
