{$}
odin = "1.0.0"
transform = "1.0.0"

{}
tier = %ifElse %gt @.purchaseAmount ##1000 "VIP" "Standard"
discount = %ifElse %gt @.purchaseAmount ##1000 "15%" "5%"
