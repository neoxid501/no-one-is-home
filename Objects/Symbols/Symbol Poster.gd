extends Spatial

#child nodes
onready var symbol = $Symbol
onready var label = $OQ_UILabel

func _ready():
	pass


#set the values for the symbol poster
func set_values(s, n, p=null):
	symbol.texture = load(G.SYMBOL_PATH[s])
	label.set_label_text(str(n))
	if p != null:
		global_transform.origin = p
