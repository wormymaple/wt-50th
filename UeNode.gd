extends Node2D

var selected = false
var myClickPos
var myDistance = Vector2(0,0)
var lineClickingOutput = false
var lineClickingInput = false
var hoveringInput = false
var hoveringOutput = false
var inputConnected = false
var outputConnected = false

export var nodeType = "unset"

func _process(delta):
	
	#print("hoverInput ",hoveringInput)
	#print("hoverOutput ",hoveringOutput)
	
	if hoveringInput:
		if lineClickingOutput:
			if Input.is_action_just_released("LMC"):
				print("eurekia")
				outputConnected = true

	if hoveringOutput:
		if lineClickingInput:
			if Input.is_action_just_released("LMC"):
				print("eurekia")
				inputConnected = true
	
	if selected:
		followMouse()
	
	if lineClickingOutput == true and outputConnected == false:
		$SpawnActor/NodeLineOutput/Line2D.set_point_position(1, $SpawnActor.get_local_mouse_position())
	elif outputConnected == false:
		$SpawnActor/NodeLineOutput/Line2D.remove_point(1)
	
	if Input.is_action_just_released("LMC"):
		lineClickingOutput = false
		lineClickingInput = false
	
	if lineClickingInput == true and inputConnected == false:
		$SpawnActor/NodeLineInput/Line2D.set_point_position(1, $SpawnActor.get_local_mouse_position())
	elif inputConnected == false:
		$SpawnActor/NodeLineInput/Line2D.remove_point(1)


func followMouse():
	$SpawnActor.global_position = get_global_mouse_position()#+myDistance

func _on_Area2D_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton and event.button_index == BUTTON_LEFT:
		
		myClickPos = get_global_mouse_position()
		myDistance = get_position()-myClickPos
		
		if event.pressed:
			selected = true
		else:
			selected = false


func _on_NodeLine_input_event(viewport, event, shape_idx):
	hoveringOutput = true
	if Input.is_action_just_pressed("LMC") and outputConnected == false:
		$SpawnActor/NodeLineOutput/Line2D.add_point(get_local_mouse_position())
		lineClickingOutput = true

func _on_NodeLineInput_input_event(viewport, event, shape_idx):
	hoveringInput = true
	if Input.is_action_just_pressed("LMC") and inputConnected == false:
		$SpawnActor/NodeLineInput/Line2D.add_point(get_local_mouse_position())
		lineClickingInput = true
		

func _on_NodeLineOutput_mouse_exited():
	hoveringOutput = false


func _on_NodeLineInput_mouse_exited():
	hoveringInput = false
