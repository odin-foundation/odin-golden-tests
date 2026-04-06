{$}
odin = "1.0.0"
transform = "1.0.0"
direction = "xml->odin"
target.format = "odin"
description = "Transform XML with default namespace to ODIN"

; Source format configuration
{$source}
format = "xml"

; Declare default namespace
{$source.namespace}
_ = "http://example.com/order"
xsi = "http://www.w3.org/2001/XMLSchema-instance"

{order}
id = @Order.OrderId
date = @Order.OrderDate :date
status = @Order.Status

{order.customer}
name = @Order.Customer.Name
email = @Order.Customer.Email

{order.customer.address}
type = @Order.Customer.Address.@type
street = @Order.Customer.Address.Street
city = @Order.Customer.Address.City
state = @Order.Customer.Address.State
zip = @Order.Customer.Address.Zip

{order.items[]}
_loop = "Order.Items.Item"
sku = @.@sku
name = @.Name
quantity = @.Quantity :type integer
unit_price = @.UnitPrice :type currency

{order.totals}
subtotal = @Order.Totals.Subtotal :type currency
tax = @Order.Totals.Tax :type currency
total = @Order.Totals.Total :type currency
