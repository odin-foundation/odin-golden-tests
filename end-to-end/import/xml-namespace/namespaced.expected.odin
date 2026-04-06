{policy}
number = "PAP-2024-001"
effective = 2024-06-15
term = P6M
premium = #$1250.00
premium_currency = "USD"
{vehicles[] : id, vin, year, make, model, usage}
"veh1", "1HGCM82633A004352", ##2022, "Honda", "Accord", "commute"
"veh2", "5YJSA1E26MF123456", ##2023, "Tesla", "Model 3", "pleasure"
{drivers[] : primary, name.first, .last, license.number, .state, dob}
?true, "John", "Smith", "S123-456-789", "TX", 1985-03-15
?false, "Jane", "Smith", "S987-654-321", "TX", 1988-07-22
