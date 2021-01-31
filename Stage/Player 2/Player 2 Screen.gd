extends Node2D

var screen_size : Vector2 = Vector2()

func _ready():
	G.gameRoom = self
	screen_size = OS.get_window_size()
	$CenterContainer.rect_size = screen_size
	update_symbols()

#auto resize screen
func _process(delta) -> void:
	if OS.get_window_size() != screen_size: #Tests if your screen changed in size, e.g a different monitor
		screen_size = OS.get_window_size()
		$CenterContainer.rect_size = screen_size

#sync cyphers to current values
func update_symbols():
	var symbols = $CenterContainer/VBoxContainer/HBoxContainer.get_children()
	#clear all symbol textures
	for s in symbols:
		s.texture = null
	#reload the correct textures
	for s in range(G.codes[G.player][G.stage].size()):
		symbols[s].texture = load(G.SYMBOL_PATH[G.symbols[G.stage][G.codes[G.player][G.stage][s]]])
		#symbols[s].texture = load(G.SYMBOL_PATH[G.codes[G.player][G.stage][s]])
	#show the code for player 1
	if G.stage > 0:
		var code = ""
		for c in G.codes[0][G.stage-1]:
			code += str(c)
		$CenterContainer/VBoxContainer/Label.text = "\nTell Player 1 to Use This Code: " + str(code) + "\n"

#update the room to the current stage
func stage_update():
	update_symbols()
	#reveal code from previous stage
	
