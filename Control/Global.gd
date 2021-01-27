extends Node

#preloads
var pauseMenu = preload("res://UI/Pause Menu/Pause Menu.tscn")

func _ready():
	pass

func _process(_delta):
	#pause check
	if Input.is_key_pressed(KEY_ESCAPE) and get_tree().get_nodes_in_group("Pause Menu").size() <= 0:
		var p = pauseMenu.instance()
		add_child(p)

