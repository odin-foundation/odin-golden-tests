{policy}
number = "PAP-2024-001"
effective = "2024-06-15"
term = "06M"
status = "Active"
{summary}
label = "TOTALS"
vehicle_count = ##2
driver_count = ##2
total_premium = #$0001250.00
{vehicles[] : vin, year, make, model, usage}
"1HGCM82633A004352", ##2022, "Honda", "Accord", "commute"
"5YJSA1E26MF123456", ##2023, "Tesla", "Model 3", "pleasure"
{drivers[] : name.first, .last, license.number, .state, dob}
"John", "Smith", "S123-456-789", "TX", "1985-03-15"
"Jane", "Smith", "S987-654-321", "TX", "1988-07-22"
