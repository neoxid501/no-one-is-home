extends Node2D

#preloads
var geist = preload("res://Entities/2D Geist/Geist 2D.tscn")

#instance variables
export var type = 0

func _ready():
	pass

func _on_Timer_timeout():
	var g = geist.instance()
	get_parent().add_child(g)
	match type:
		0:
			g.__ready()
		1:
			g.__ready(320, 8, Geist_2D.B.CHASE)
		2:
			g.__ready(270, 12, Geist_2D.B.CHASE)
		_:
			g.__ready(190, 1, Geist_2D.B.UPDATE)
	g.global_position = global_position
	queue_free()
