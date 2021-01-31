extends Node2D

#child nodes
onready var label = $CenterContainer/VBoxContainer/Label

#instance variables
var screen_size = Vector2()

func _ready():
	resize()
	if G.player <= 0:
		if G.win:
			label.text = "You Remember\n\nVictory\n\n"
		else:
			label.text = "Lost...\n\nBut never forgotten.\n\n"
	else:
		if G.win:
			label.text = "They've Found Themselves\n\nThanks to You\n\n"
		else:
			label.text = "You failed... but your friend still needs you.\nWant to go back?\n(Enter the same seed at the main menu to continue.Previous passwords will not have changed.)"

#auto resize screen
func _process(delta) -> void:
	if OS.get_window_size() != screen_size: #Tests if your screen changed in size, e.g a different monitor
		resize()

#resize elements
func resize():
	screen_size = OS.get_window_size()
	$CenterContainer.rect_size = screen_size
	var scale = get_viewport().size.x / $Sprite.texture.get_size().x
	$Sprite.set_scale(Vector2(scale, scale))

#return to main menu, reset game
func _on_Button_pressed():
	G.reset_game()
