extends CenterContainer

signal dismissed

#instance variable
export var perm = false

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	$VBoxContainer/TextEdit.grab_focus()

func _process(_delta):
	if Input.is_key_pressed(KEY_ENTER):
		var txt = $VBoxContainer/TextEdit.text
		#verify entered code
		if check_code(txt):
			G.advance_stage()
		#remove
		if !perm:
			Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
			emit_signal("dismissed")
			queue_free()
		else: #reset
			$VBoxContainer/TextEdit.text = ""

#checks the code against the player's needed code
func check_code(code):
	var i = 0 #iterator
	for c in code:
		if i >= G.codes[G.player][G.stage].size():
			return true
		if int(c) != G.codes[G.player][G.stage][i]:
			return false
		i += 1
	return false #empty

