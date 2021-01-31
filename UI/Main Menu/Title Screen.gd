extends Node2D

#child variables
onready var playerOption = $"CenterContainer/VBoxContainer/PlayerNumber"

#instance variables
var screen_size = Vector2()


func _ready():
	resize()
	#add the buttons
	add_option_buttons()

#adds buttons to any optionbuttons
func add_option_buttons():
	playerOption.add_item("The Lost (Player 1)")
	playerOption.add_item("A Friend (Player 2+)")

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

#start the game
func _on_Button_pressed():
	G.player = playerOption.get_selected_id()
	G.start_game($CenterContainer/VBoxContainer/TextEdit.text.hash())
