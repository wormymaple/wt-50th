extends Control

var suspect = null
var PossibleSuspects = ["pirate", "kid", "ghost"]
var passed = null
var failed = null

func _ready():
	#This randomizes the suspect
	randomize()
	suspect = PossibleSuspects[randi() % PossibleSuspects.size()]
	#print(suspect)
	
	#This makes the correct suspect visible
	if suspect == "pirate":
		$OtherUILayer/Kid.visible = false
		$OtherUILayer/Ghost.visible = false
	if suspect == "kid":
		$OtherUILayer/Pirate.visible = false
		$OtherUILayer/Ghost.visible = false
	if suspect == "ghost":
		$OtherUILayer/Pirate.visible = false
		$OtherUILayer/Kid.visible = false

func player_win():
	passed = true
	#print("You win!")
func player_lose():
	failed = true
	#print("You lose!")

func _on_ClothButton_pressed():
	if passed or failed:
		return
	if suspect == "kid":
		player_win()
	else:
		player_lose()

func _on_HookButton_pressed():
	if passed or failed:
		return
	if suspect == "pirate":
		player_win()
	else:
		player_lose()

func _on_PhototButton_pressed():
	if passed or failed:
		return
	if suspect == "ghost": 
		player_win()
	else:
		player_lose()

func _on_KnifeButton_pressed():
	if passed or failed:
		return
	player_lose() # No check because no criminal has been made for the knife yet
