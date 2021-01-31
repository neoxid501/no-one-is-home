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

#update give up button
func _on_Give_Up_pressed():
	match $"VBoxContainer/Give Up".text:
		"Give Up":
			$"VBoxContainer/Give Up".text = "Don't Do It"
		"Don't Do It":
			$"VBoxContainer/Give Up".text = "You're Worth It"
		"You're Worth It":
			$"VBoxContainer/Give Up".text = "Please?"
		"Please?":
			$"VBoxContainer/Give Up".text = "You sure?"
		"You sure?":
			$"VBoxContainer/Give Up".text = "Last chance..."
		"Last chance...":
			get_tree().paused = false
			G.advance_stage(true)
			queue_free()
