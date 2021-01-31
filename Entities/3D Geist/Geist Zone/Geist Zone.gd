extends Spatial

signal contact

#child nodes
onready var geist = $"Geist 3D"

func _ready():
	pass

#set geist target
func _on_Area_body_entered(body):
	if body.is_in_group("Player"):
		geist.target = body

#remove geist target
func _on_Area_body_exited(body):
	if body.is_in_group("Player"):
		geist.target = null

#contact signal pass
func _on_Geist_3D_contact():
	emit_signal("contact")
