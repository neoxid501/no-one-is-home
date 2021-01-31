extends Node2D

class_name Geist_2D

#constants
enum B {STOP, CHASE, UPDATE}
const MOVE_THRESH = 20
const DEF_SPD = 300
const DEF_UPD = 2

#instance variables
var move = true
var chasing = false
export var spd = DEF_SPD
export var updateFreq = DEF_UPD #how often to update the position of the target
var behavior = B.STOP #behavior to do after reaching target position
var target = Vector2() #v2d to move to


func _ready():
	$Timer.start(updateFreq)

func __ready(s=DEF_SPD, u=DEF_UPD, b=B.STOP):
	spd = s
	updateFreq = u
	behavior = b

#move toward the target
func _process(delta):
	if move:
		var dir = global_position.direction_to(target)
		if global_position.distance_to(target) < MOVE_THRESH or chasing: #target reached
			match behavior:
				B.STOP: #wait and do nothing until this timer goes off
					move = false
				B.CHASE: #go to target, chase until new target added
					dir = global_position.direction_to(get_viewport().get_mouse_position())
					global_position += dir * spd * delta
					chasing = true
				B.UPDATE: #when the target is reached update immediately, timer not needed
					target = get_viewport().get_mouse_position()
		else: #move to target
			global_position += dir * spd * delta

#update based on behavior
func _on_Timer_timeout():
	target = get_viewport().get_mouse_position()
	match behavior:
		B.STOP: #wait and do nothing until this timer goes off
			move = true
		B.CHASE: #go to target, chase until new target added
			chasing = false
		B.UPDATE: #when the target is reached update immediately, timer not needed
			return
	$Timer.start(updateFreq)
