extends CenterContainer

signal dismissed

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)

func _process(_delta):
	if Input.is_key_pressed(KEY_ENTER):
		Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
		var txt = $VBoxContainer/TextEdit.text
		print(txt)
		emit_signal("dismissed")
		queue_free()

