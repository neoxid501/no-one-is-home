extends Node2D

onready var spr = get_node("CanvasLayer/Sprite")

onready var scene = ""
onready var a = 0.0
onready var go = false
onready var packed = false #if the given scene var is a packed scene or a string ref

onready var fadeSpeed = 0.03

func _ready():
	spr.modulate = Color(1, 1, 1, 0)

func _process(_delta):
	a = clamp(a+fadeSpeed, -1, 1)
	spr.modulate = Color(1, 1, 1, a)
	if(a >= 1 and !go):
		go = true
		if(packed):
			get_tree().change_scene_to(scene)
		else:
			get_tree().change_scene(scene)
		fadeSpeed *= -1
	if(a < 0):
		queue_free()

func set_scene(sc):
	scene = sc

func set_packed(p):
	packed = p
