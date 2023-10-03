onready var box = preload('res://box.tscn')
func _ready():
	new_box()
func new_box():
	var new_box = box.instance()
	add_child(new_box)
	if	event is inputeventmousebutton and event.pressed and event.button_index == BUTTON_LEFT:
		print ("lol it works")
		queue_free()
_on_box_input_event (vieqport, event, shape_idx)
