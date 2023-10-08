extends Control

onready var GameTimer = $Timer
onready var TimeLabel = $SidePanel/MarginContainer/TimeLeft
onready var TimeBar = $SidePanel/TextureProgress#$SidePanel/MarginContainer4/TextureProgress #$SidePanel/MarginContainer2/TimeBar
var NewTimerMax = 10

#You do not have to make variables for colors but I am because I like to grab colors from the docs
var yellow = Color( 1, 1, 0, 1 )
var red = Color(1,0,0)
var orange = Color(1,.5,0)


func _ready(): #This is the start of the game
	_new_scene()
	TimeBar.set_max(NewTimerMax)
	
func _new_scene(): #This should be called every time that a new game is going to be loaded
	TimeBar.set_value(5)#GameTimer.wait_time)
	TimeBar.set_max(NewTimerMax)
	#load("res://Game Assets/UserInterface/Scenes/Stopwatch.tscn")
	

func game_cleared():
	print("You cleared a game")
	NewTimerMax -= 1


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
		

func _fail():
	print("Game Over")


func _on_Timer_timeout():
	_fail()


func _on_QuitButton_pressed():
	get_tree().change_scene("res://Game Assets/UserInterface/Scenes/Title screen.tscn")
