extends Control

onready var GameTimer = $Timer
onready var TimeLabel = $SidePanel/MarginContainer/TimeLeft
onready var TimeBar = $SidePanel/MarginContainer/TimeBar

#This is the start of the game
func _ready():
	#Makes the TimeBar fill deplete from the top
	#TimeBar.set_fill_mode(3)
	_new_scene()
	TimeBar.set_max(10)

func _new_scene():
	TimeBar.set_max(5)#GameTimer.wait_time)
	

func _process(_delta):
	TimeLabel.text = str(round(GameTimer.time_left))
	TimeBar.value = GameTimer.time_left


func _fail():
	print("Game Over")


func _on_Timer_timeout():
	_fail()
