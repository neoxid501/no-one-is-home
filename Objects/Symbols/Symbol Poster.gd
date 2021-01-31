extends Spatial

#child nodes
onready var beacon = $Beacon
onready var poster = $Poster
onready var symbol = $Poster/Symbol
onready var label = $Poster/OQ_UILabel

func _ready():
	pass


#set the values for the symbol poster
func set_values(s, n, p=null):
	symbol.texture = load(G.SYMBOL_PATH[s])
	label.set_label_text(str(n))
	if p != null:
		global_transform.origin = p


func _on_Area_body_entered(body):
	if body.is_in_group("Player"):
		$AnimationPlayer.play("Visited")
		beacon.hide()
		poster.show()


func _on_Area_body_exited(body):
	if body.is_in_group("Player"):
		beacon.show()
		poster.hide()
