{$}
odin = "1.0.0"
transform = "1.0.0"
direction = "yaml->odin"
target.format = "odin"
description = "Import YAML configuration to ODIN with indentation"

; YAML nesting maps to ODIN segments
; YAML arrays map to ODIN tabular arrays

{$source}
format = "yaml"

{application}
name = @application.name
version = @application.version
debug = @application.debug

{database}
host = @database.host
port = @database.port :type integer
name = @database.name

{database.credentials}
user = @database.credentials.user
password = @database.credentials.password :confidential

{server}
host = @server.host
port = @server.port :type integer
ssl = @server.ssl
timeout = @server.timeout :type integer

{features[] : name, enabled}
_loop = "@features"
name = @.name
enabled = @.enabled
