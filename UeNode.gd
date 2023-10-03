extends Node2D

var selected = false
var myClickPos
var myDistance = Vector2(0,0)
var lineClickingOutput = false
var lineClickingInput = false

export var nodeType = "unset"

func _ready():
	pass

func _process(delta):
	if selected:
		followMouse()
	
	if lineClickingOutput == true:
		$NodeLineOutput/Line2D.set_point_position(1, get_local_mouse_position())
	else:
		$NodeLineOutput/Line2D.remove_point(1)
	
	if Input.is_action_just_released("LMC"):
		lineClickingOutput = false
		lineClickingInput = false
	
	if lineClickingInput == true:
		$NodeLineInput/Line2D.set_point_position(1, get_local_mouse_position())
	else:
		$NodeLineInput/Line2D.remove_point(1)


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


func _on_NodeLine_input_event(viewport, event, shape_idx):
	if Input.is_action_just_pressed("LMC"):
		$NodeLineOutput/Line2D.add_point(get_local_mouse_position())
		lineClickingOutput = true
	

func _on_NodeLineInput_input_event(viewport, event, shape_idx):
	if Input.is_action_just_pressed("LMC"):
		$NodeLineInput/Line2D.add_point(get_local_mouse_position())
		lineClickingInput = true
