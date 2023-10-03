extends Node2D

var selected = false
var myClickPos
var myDistance = Vector2(0,0)

func _ready():
	pass 

func _process(delta):
	if selected:
		followMouse()

func followMouse():
	position = get_global_mouse_position()+myDistance

func _on_Area2D_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton and event.button_index == BUTTON_LEFT:
		
		myClickPos = get_global_mouse_position()
		myDistance = get_position()-myClickPos
		
		if event.pressed:
			selected = true
		else:
			selected = false
