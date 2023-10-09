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
	$WinLoseLabel.hide()
	$WinLoseOverlay.hide()
	#This randomizes the suspect
	randomize()
	suspect = PossibleSuspects[randi() % PossibleSuspects.size()]
	print(suspect)
	
	#This makes the correct suspect visible
	if suspect == "pirate":
		$Kid.visible = false
		$Ghost.visible = false
	if suspect == "kid":
		$Pirate.visible = false
		$Ghost.visible = false
	if suspect == "ghost":
		$Pirate.visible = false
		$Kid.visible = false
		$Judge.visible = false


func player_win():
	#Make victory text appear and stuff
	#Send out victory signal
	passed = true
	$WinLoseLabel.text = "PASSED!"
	$WinLoseLabel.set_modulate(Color(0,1,0))
	$WinLoseLabel.show()
	$WinLoseOverlay.show()
	#print("starting fade in!")	
	StartFadeIn = true
	
	print("You win!")

func _process(delta):
	if StartFadeIn:
		#$WinLoseLabel.set_modulate(Color(1,1,1,FadeInValue))
		$WinLoseOverlay.set_modulate(Color(0.294,0.294,0.294,FadeInValue))
		while $WinLoseLabel.rect_position.y < 296:
			$WinLoseLabel.rect_position += 1
		while FadeInValue < 0.5:
			print(FadeInValue)
			FadeInValue += .01

func player_lose():
	print("Lose!")
	$WinLoseLabel.text = "FAILED!"
	$WinLoseLabel.set_modulate(Color(1,0,0))
	$WinLoseLabel.show()
	StartFadeIn = true
	$WinLoseOverlay.show()
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

func _on_KnifeButton_pressed():
	player_lose()
func _on_PhototButton_pressed():
	if suspect == "ghost": 
		player_win()
	else:
		player_lose()


