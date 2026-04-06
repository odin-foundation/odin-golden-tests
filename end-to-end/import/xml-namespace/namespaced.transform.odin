{$}
odin = "1.0.0"
transform = "1.0.0"
direction = "xml->odin"
target.format = "odin"
description = "Transform namespaced XML (SOAP envelope) to ODIN"

; Source format configuration
{$source}
format = "xml"

; Declare namespace prefixes for source parsing
{$source.namespace}
soapenv = "http://schemas.xmlsoap.org/soap/envelope/"
pol = "http://example.com/policy"
veh = "http://example.com/vehicle"
drv = "http://example.com/driver"

; Policy information from pol namespace
{policy}
number = @soapenv:Envelope.soapenv:Body.pol:PolicyRequest.pol:PolicyNumber
effective = @soapenv:Envelope.soapenv:Body.pol:PolicyRequest.pol:EffectiveDate :date
term = @soapenv:Envelope.soapenv:Body.pol:PolicyRequest.pol:Term :duration
premium = @soapenv:Envelope.soapenv:Body.pol:PolicyRequest.pol:Premium._text :type currency
premium_currency = @soapenv:Envelope.soapenv:Body.pol:PolicyRequest.pol:Premium.@currency

; Vehicles from veh namespace
{vehicles[]}
_loop = "soapenv:Envelope.soapenv:Body.pol:PolicyRequest.veh:Vehicle"
id = @.@id
vin = @.veh:VIN
year = @.veh:Year :type integer
make = @.veh:Make
model = @.veh:Model
usage = @.veh:Usage

; Drivers from drv namespace
{drivers[]}
_loop = "soapenv:Envelope.soapenv:Body.pol:PolicyRequest.drv:Driver"
primary = @.@primary :type boolean
name.first = @.drv:Name.drv:First
name.last = @.drv:Name.drv:Last
license.number = @.drv:License.drv:Number
license.state = @.drv:License.drv:State
dob = @.drv:DateOfBirth :date
