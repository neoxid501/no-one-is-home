extends CenterContainer

#free the mouse
func _ready():
	get_tree().paused = true
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)

#resume play
func _on_Resume_pressed():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	get_tree().paused = false
	queue_free()

#quit the game
func _on_Quit_pressed():
	get_tree().quit()
