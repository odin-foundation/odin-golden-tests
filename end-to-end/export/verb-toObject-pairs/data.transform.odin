{$}
odin = "1.0.0"
transform = "1.0.0"
direction = "json->json"
target.format = "json"
target.indent = ##2

; %chunk yields nested-array (pair) items; %toObject rebuilds the object.
{result}
asObject = %toObject %chunk @.flat ##2
