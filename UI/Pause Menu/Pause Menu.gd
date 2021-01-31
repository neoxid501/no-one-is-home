extends CenterContainer

var screen_size : Vector2 = Vector2()

#free the mouse
func _ready():
	get_tree().paused = true
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	screen_size = OS.get_window_size()
	rect_size = screen_size

#auto resize screen
func _process(delta) -> void:
	if OS.get_window_size() != screen_size: #Tests if your screen changed in size, e.g a different monitor
		screen_size = OS.get_window_size()
		$CenterContainer.rect_size = screen_size

#resume play
func _on_Resume_pressed():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	get_tree().paused = false
	queue_free()

#quit the game
func _on_Quit_pressed():
	get_tree().quit()
