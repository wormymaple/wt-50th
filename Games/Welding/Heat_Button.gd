extends Button

var is_pressed = false 
var heat: float 
var max_or_min: bool 

func _on_Button_button_down():
	is_pressed = true
	heat += 1

func _on_Button_button_up():
	is_pressed = false
	heat -= 1

func _process(delta):
	if heat <= 0 or heat >= 100:
		max_or_min = true
	elif heat > 0 and heat < 100:
		max_or_min = false
	if is_pressed == true and max_or_min == false: 
		heat += 1
	elif is_pressed == false and max_or_min == false:
		heat -= 1
	$Heat_Bar.value = heat 
