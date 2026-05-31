{$}
odin = "1.0.0"
transform = "1.0.0"
direction = "odin->xml"
target.format = "xml"

{$source}
format = "odin"

{$target.namespace}
ins = "http://www.example.org/insurance/"

{Policy}
PolicyNumber = @policy.number :ns ins
Holder = @policy.holder
