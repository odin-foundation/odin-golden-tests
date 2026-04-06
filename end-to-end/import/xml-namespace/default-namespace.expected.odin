{order}
id = "ORD-2024-0001"
date = 2024-12-20
status = ~
{.items[] : sku, name, quantity, unit_price}
"WIDGET-001", "Standard Widget", ##10, #$29.99
"GADGET-002", "Premium Gadget", ##5, #$149.50
{.customer}
name = "Acme Corporation"
email = "orders@acme.com"
{order.customer.address}
type = "billing"
street = "123 Main Street"
city = "Austin"
state = "TX"
zip = "78701"
{.totals}
subtotal = #$1047.40
tax = #$86.41
total = #$1133.81
