{policy}
number = "PAP-2024-001"
effective = 2024-06-15
term_months = "6M"
premium = #$1250.00
{vehicles[] : vin, year, make, model}
"1HGCM82633A004352", ##2022, "Honda", "Accord"
"5YJSA1E26MF123456", ##2023, "Tesla", "Model 3"
{drivers[] : name.first, .last, license.number, .state, dob, primary}
"John", "Smith", "S123-456-789", "TX", 1985-03-15, ?true
"Jane", "Smith", "S987-654-321", "TX", 1988-07-22, ?false
{coverages[] : type, limit, premium}
"liability", ##100000, #$250.00
"collision", ##500, #$400.00
"comprehensive", ##250, #$200.00
