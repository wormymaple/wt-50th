extends Control

onready var GameTimer = $Timer
onready var TimeLabel = $SidePanel/MarginContainer/TimeLeft
onready var TimeBar = $SidePanel/TextureProgress
var NewTimerMax = 10
var game = null

#You do not have to make variables for colors but I am because I like to grab colors from the docs
#These are not currently being used
var yellow = Color( 1, 1, 0, 1 )
var red = Color(1,0,0)
var orange = Color(1,.5,0)


func _ready(): #This is when this scene is first loaded.
	new_scene()
	TimeBar.set_max(NewTimerMax)
	
func new_scene(): #This should be called every time that a new game is going to be loaded
	TimeBar.set_value(NewTimerMax) #Resets value for each new minigame
	TimeBar.set_max(NewTimerMax) #This updates the max value of the time bar
	var scene = load("res://Game Assets/UserInterface/Scenes/Stopwatch.tscn") #Creates a new scene
	game = scene.instance() #
	$GameHolder.add_child(game)
	#print("Scene loaded!")

func _fail():
	print("Game Over")
	game.queue_free() #Game knows what scene game is

func game_cleared():
	print("You cleared a game")
	#$GameHolder.get_child.queue_free()
	NewTimerMax -= 1
	new_scene()


func _process(_delta):
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
	
	#var test = lerp(1, 100, 1)
	#print(test)
	#print(YellowSoonToBeRed)
	
	#if round(GameTimer.time_left) == 5:
		#TimeLabel. add_color_override ("font_color", yellow)
		#TimeBar.tint_progress = Color( 1, 1, 0)
		#TimeBar.tint_under = Color( 1, 1, 0)
	#if round(GameTimer.time_left) == 3:
		#TimeLabel.add_color_override("font_color", orange)
		#TimeBar.tint_progress = Color( 1, .5, 0)
		#TimeBar.tint_under = Color( 1, .5, 0)
	#if round(GameTimer.time_left) == 1:
		#TimeLabel.add_color_override("font_color", red)
		#TimeBar.tint_progress = Color( 1, 0, 0)
		#TimeBar.tint_under = Color( 1, 0, 0)
		




func _on_Timer_timeout():
	_fail()


func _on_QuitButton_pressed():
	get_tree().change_scene("res://Game Assets/UserInterface/Scenes/Title screen.tscn")


func _on_GameHolder_child_entered_tree(node):
	print("Gameholder loaded scene")
