extends Control

onready var GameTimer = $CanvasLayer/Timer
onready var TimeLabel = $CanvasLayer/SidePanel/MarginContainer/TimeLeft
onready var TimeBar = $CanvasLayer/SidePanel/TextureProgress
var NewTimerMax = 10.0
var OG_Time: float
var game = null

var set_game_state = true

export var pass_fail: NodePath
export var total_games: NodePath
var completed_games = 0

export(Array, PackedScene) var possible_scenes

export var total_fade: NodePath
var failed: bool

func _ready(): #This is when this scene is first loaded.
	OG_Time = NewTimerMax
	new_scene(true)
	
func new_scene(passed):
	if !passed:
		get_tree().change_scene("res://Game Assets/UserInterface/Scenes/Title screen.tscn")
		return
		
	NewTimerMax = OG_Time
	GameTimer.wait_time = NewTimerMax
	GameTimer.start()
	TimeBar.set_value(NewTimerMax) #Resets value for each new minigame
	TimeBar.set_max(NewTimerMax) #This updates the max value of the time bar
	
	if game != null:
		game.queue_free()
		game = null
		
	var rng = RandomNumberGenerator.new()
	rng.randomize()
	game = possible_scenes[rng.randi_range(0, len(possible_scenes) - 1)].instance()
	$CanvasLayer/GameHolder.add_child(game)
	
	set_game_state = false	
	

func _fail():
	failed = true
	get_node(total_games).bbcode_text = "[center]Total Games: " + str(completed_games)
	game.queue_free() #Game knows what scene game is
	game = null
	GameTimer.stop()
	get_node(pass_fail).show_fail()

func _process(_delta):
	if failed:
		get_node(total_fade).modulate.a += _delta / 2
		
		return
	
	#Timer stuff
	TimeLabel.set_text(str(round(GameTimer.time_left)))
	TimeBar.set_value(GameTimer.time_left)
	
	if GameTimer.time_left > 5:
		#Go from green to yellow (0,1,0) to (1,1,0)
		TimeBar.tint_progress = Color((1-(GameTimer.time_left-5)/5),1,0) #At the beginning this should be 10 which when subtracted 5 from and divided by 5 would be 1. Subtracting this from 1 would make the red value become stronger overtime until it is strongest, at five seconds
		TimeBar.tint_under = Color((1-(GameTimer.time_left-5)/5),1,0)
	else:
		TimeBar.tint_progress = Color(1,GameTimer.time_left/5,0) #When this triggers the timer will only have at most 10 seconds so you can divide it by 5 and have at most 1 which as the timer decreases this makes the green value slowly dissapear
		TimeBar.tint_under = Color(1,GameTimer.time_left/5,0)
	
	if game == null or set_game_state:
		return
	
	#check if the player has failed or passed a scene yet
	if game.passed:
		set_game_state = true
		get_node(pass_fail).show_pass()
		completed_games += 1
		get_node(total_games).bbcode_text = "[center]Total Games: " + str(completed_games)
		GameTimer.stop()
		
	if game.failed:
		set_game_state = true
		_fail()
		
		




func _on_Timer_timeout():
	_fail()

func _on_QuitButton_pressed():
	get_tree().change_scene("res://Game Assets/UserInterface/Scenes/Title screen.tscn")


func _on_GameHolder_child_entered_tree(node):
	print("Gameholder loaded scene")
