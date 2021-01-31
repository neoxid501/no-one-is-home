extends Spatial

#preloads
var poster = preload("res://Objects/Symbols/Symbol Poster.tscn")

func _ready():
	G.gameRoom = self
	spawn_posters()

#generate posters based on current stage in global
func spawn_posters():
	#free any previous nodes
	for p in get_tree().get_nodes_in_group("Symbol Poster"):
		p.queue_free()
	#get all positions, and spawn the approrpiate poster there
	var i = 0 #iterator to keep track of which position we're on
	for pos in $Positions.get_children():
		var c = G.posterPos[G.stage][i] #index of the symbol to put
		var p = poster.instance()
		pos.add_child(p)
		#set the symbol, value, and position
		p.set_values(G.symbols[G.stage][i], c, pos.global_transform.origin)
		#iterate
		i += 1

#update the stage to the current values
func stage_update():
	spawn_posters()


func _on_Geist_Zone_contact():
	$Player.global_transform = $"Respawn Point".global_transform
