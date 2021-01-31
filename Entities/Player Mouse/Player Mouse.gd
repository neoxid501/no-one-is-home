extends Node2D

signal hit

func _ready():
	pass

func _process(delta):
	global_position = get_viewport().get_mouse_position()

#collision
func _on_Area2D_area_entered(area):
	if area.is_in_group("Geist"):
		emit_signal("hit")
