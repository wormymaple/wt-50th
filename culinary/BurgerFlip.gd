extends Node2D

var burgerCooked = false
var timeToCookBurger = 3.0
var burgerOvercooked = false;

var cookTimer = Timer.new()

var burgerFliped = false;

signal burgerDone(quality)

onready var BURGER = preload("res://culinary/BurgerPart.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	burgerIsCooking()


# Called every frame. 'delta' is the elapsed time since the previous frame.
# warning-ignore:unused_argument
func _physics_process(delta):
	pass
	
func burgerIsCooking():
	$CookingProgress.modulate = Color(255,255,0,255)
	var cookFrequency = timeToCookBurger / 100 
	for i in range(101):
		yield(get_tree().create_timer(cookFrequency), "timeout")
		$BurgerCookProgress.value = i
		if burgerFliped == true:
			break
	if burgerFliped != true:
		$CookingProgress.modulate = Color(0,255,0,255)
		burgerCooked = true
	burgerCooked = true;
	cookFrequency = cookFrequency / 2 
	for g in range(101):
		yield(get_tree().create_timer(cookFrequency), "timeout")
		$BurgerOvercookProgress.value = g
		if burgerFliped == true:
			break
	if burgerFliped != true:
		burgerOvercooked = true
		$CookingProgress.modulate = Color(255,0,0,255)

func _on_FlipBurger_button_down():
	if burgerFliped == false:
		burgerFliped = true
	if burgerCooked == false:
		emit_signal("burgerDone", "Undercooked")
	elif burgerOvercooked == false:
		emit_signal("burgerDone","Good")
	else:
		emit_signal("burgerDone", "Overcooked")
	$BurgerOvercookProgress.visible = false
	$BurgerCookProgress.visible = false
	$FlipBurger.disabled = true
	var burgerPart3 = BURGER.instance()
	burgerPart3.set_global_position(Vector2(100, 45))
	add_child(burgerPart3)
