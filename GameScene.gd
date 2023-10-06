extends Control

onready var GameTimer = $Timer
onready var TimeLabel = $SidePanel/MarginContainer/TimeLeft
onready var TimeBar = $SidePanel/MarginContainer2/TimeBar
var NewTimerMax = 10

#This is the start of the game
func _ready():
	#Makes the TimeBar fill deplete from the top, if needed
	#TimeBar.set_fill_mode(3)
	_new_scene()
	TimeBar.set_max(NewTimerMax)
	

func _new_scene():
	TimeBar.set_value(5)#GameTimer.wait_time)
	TimeBar.set_max(NewTimerMax)
	load("res://Game Assets/UserInterface/Scenes/Stopwatch.tscn")
	

func game_cleared():
	print("You cleared a game")
	NewTimerMax -= 1
	

func _process(_delta):
	TimeLabel.set_text(str(round(GameTimer.time_left)))
	TimeBar.set_value(GameTimer.time_left)


func _fail():
	print("Game Over")


func _on_Timer_timeout():
	_fail()
