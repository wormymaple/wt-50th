extends Button

var is_pressed = false 
var heat: float 
var max_or_min: bool 
var score: int
export var color: Gradient

func _on_Heat_Bar_value_changed(_value):
	$Heat_Bar.color = color.interpolate(heat)

func _on_Button_button_down():
	is_pressed = true
	heat += 1

func _on_Button_button_up():
	is_pressed = false
	heat -= 1

func _process(_delta):
	if heat <= 0 or heat >= 100:
		max_or_min = true
	elif heat > 0 and heat < 100:
		max_or_min = false
	if is_pressed == true and max_or_min == false: 
		heat += 1
	elif is_pressed == false and max_or_min == false:
		heat -= 1
	$Heat_Bar.value = heat 
	if heat < 75 and heat > 25:
		score += 1
		print(score)
