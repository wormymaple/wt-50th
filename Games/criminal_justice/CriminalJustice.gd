extends Control

var suspect = null
var PossibleSuspects = ["pirate", "kid", "ghost"]
var passed = null
var failed = null
var FadeInValue = 0
#Stopwatch stuff:
#var FadeInStopwatch = null
var StartFadeIn = false
#var ElapsedTime: float = 0.0
#var ElapsedDelta = 0
#var CurrentSecondThreshold = 0.1

#var rng = RandomNumberGenerator.new()

func _ready():
	#This randomizes the suspect
	randomize()
	suspect = PossibleSuspects[randi() % PossibleSuspects.size()]
	print(suspect)
	
	#This makes the correct suspect visible
	if suspect == "pirate":
		$CanvasLayer2/Kid.visible = false
		$CanvasLayer2/Ghost.visible = false
	if suspect == "kid":
		$CanvasLayer2/Pirate.visible = false
		$CanvasLayer2/Ghost.visible = false
	if suspect == "ghost":
		$CanvasLayer2/Pirate.visible = false
		$CanvasLayer2/Kid.visible = false
		$CanvasLayer2/Judge.visible = false


func player_win():
	#$CanvasLayer.visible = false
	$CanvasLayer.layer = 0
	#Make victory text appear and stuff
	passed = true
	#print("starting fade in!")	
	StartFadeIn = true
	
	print("You win!")


func player_lose():
	#$CanvasLayer.visible = false
	$CanvasLayer.layer = 0
	print("Lose!")
	StartFadeIn = true
	#$WinLoseLabel.add_color_override("font_color", Color(1,0,0))
	failed = true


func _on_ClothButton_pressed():
	if suspect == "kid":
		player_win()
	else:
		player_lose()

func _on_HookButton_pressed():
	if suspect == "pirate":
		player_win()
	else:
		player_lose()

func _on_PhototButton_pressed():
	if suspect == "ghost": 
		player_win()
	else:
		player_lose()

func _on_KnifeButton_pressed():
	player_lose()
