extends Spatial

signal contact

#instance variables
var spd = 7
var target = null

func _ready():
	pass

func _process(delta):
	if target != null:
		#rotation
		look_at(target.global_transform.origin, Vector3.UP)
		#move toward target
		var dir = global_transform.origin.direction_to(target.global_transform.origin)
		global_transform.origin += dir * spd * delta

func _on_Area_body_entered(body):
	if body.is_in_group("Player"):
		emit_signal("contact")
