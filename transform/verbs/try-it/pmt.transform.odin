{$}
odin = "1.0.0"
transform = "1.0.0"

{}
monthlyPayment = %round %pmt @.principal %divide @.annualRate ##12 %multiply @.years ##12 ##2
