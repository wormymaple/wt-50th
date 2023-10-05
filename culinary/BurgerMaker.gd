extends Node2D

var pattyGood = false
var patty = false
var tomato = false
var lettuce = false
var burgerQuality;
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _on_BurgerMaker_burgerItemAdd(itemToAdd):
	if itemToAdd == "Lettuce":
		lettuce = true
		pass
	elif itemToAdd == "Tomato":
		tomato = true
		pass
	else:
		patty = true
		pass
	if lettuce == true && tomato == true && patty == true:
		if pattyGood == false:
			print("the burger was " + burgerQuality)
		else:
			print("Win Now")
		# GOTONEXTGAMEHERE


func _on_BurgerFlip_burgerDone(quality):
	if quality == "Good":
		pattyGood = true
	burgerQuality = quality
