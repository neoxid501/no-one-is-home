extends Node

#preloads
var pauseMenu = preload("res://UI/Pause Menu/Pause Menu.tscn")

#paths
const SYMBOL_PATH = [
	"res://Objects/Symbols/Images/0.png",
	"res://Objects/Symbols/Images/1.png",
	"res://Objects/Symbols/Images/2.png",
	"res://Objects/Symbols/Images/3.png",
	"res://Objects/Symbols/Images/4.png",
	"res://Objects/Symbols/Images/5.png",
	"res://Objects/Symbols/Images/6.png",
	"res://Objects/Symbols/Images/7.png",
	"res://Objects/Symbols/Images/8.png",
	"res://Objects/Symbols/Images/9.png"
]

#constants
enum DIFF {EASY}
#gameplay
var CODE_LENGTH = [[3, 3, 4]]
var TIME_LIMIT = [[8]]

#instance variables
#game variables
var player = 0
var stage = 0
var gameRoom = null #reference to the current game room
#player variables
var difficulty = DIFF.EASY
var codes = [] #3d array for player codes | 1D - player, 2D - code per stage, 3d - code
var symbols = [] #2d array for symbols to use for each code | 1D - stage, 2D - symbol index
var posterPos = [] #2d array for the positions to spawn the symbols | same as above

func _ready():
	pass
	
	#TEST LINES
	
	start_game(1239584)
	print(str("Codes: ", codes, "\nSymbols: ", symbols, "\nPositions: ", posterPos))

func _process(_delta):
	#pause check
	if Input.is_key_pressed(KEY_ESCAPE) and get_tree().get_nodes_in_group("Pause Menu").size() <= 0:
		var p = pauseMenu.instance()
		add_child(p)

# ----- Gameplay -----

#begins a new game
func start_game(newSeed):
	seed(newSeed)
	stage = 0
	generate_game()
	#redirect to proper scene depending on player number
	if player <= 0:
		get_tree().change_scene_to(load("res://Stage/Mindscape Variant 1/Mindescape v1.tscn"))
	else:
		get_tree().change_scene_to(load("res://Stage/Player 2/Player 2 Screen.tscn"))

#resets the game variables so a new one can be started
func reset_game():
	stage = 0

#advances gameplay to the next stage
func advance_stage():
	stage += 1
	#check for victory
	if stage >= CODE_LENGTH[difficulty].size():
		pass
	else: #call the gameroom to update the stage values
		gameRoom.stage_update()

# ----- Generation -----

#all calls that require randomization are done here to avoid further changing
# the seed after it's set by the players
func generate_game():
	generate_player_codes()
	generate_symbols_cypher()
	generate_poster_positions()

#generate the codes that players use to advance to the next stage
func generate_player_codes():
	#iterate once per player
	for _player in range(2):
		var pCodes = []
		#iterate through each needed code length generating a code and symbols
		for codeLength in CODE_LENGTH[difficulty]:
			#generate a code for the stage
			var code = [] #current code
			while code.size() < codeLength:
				var num = randi() % 10 #generate number 0 - 9
				if !code.has(num): #unique number
					code.append(num)
			pCodes.append(code) #add code to list of player codes
		codes.append(pCodes)

#determine which symbols correspond to what number
func generate_symbols_cypher():
	for _stages in CODE_LENGTH[difficulty]:
		var cypher = [] #current cypher
		while cypher.size() < 10:
			var num = randi() % SYMBOL_PATH.size() #generate number 0 - number of symbols
			if !cypher.has(num): #unique number, a symbol cannot represent 2 numbers
				cypher.append(num)
		symbols.append(cypher)

#generate a random order for the symbol posters to spawn in
func generate_poster_positions():
	for _stages in CODE_LENGTH[difficulty]:
		var pos = []
		for i in range(10): #fill with 0-9
			pos.append(i)
		pos.shuffle()
		posterPos.append(pos)
