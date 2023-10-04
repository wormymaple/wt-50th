extends Node2D

var beginPlayLineMade = false

func _process(delta):
	if beginPlayLineMade:
		$BeginPlay/StartBeginPlay/LineBeginPlay.set_point_position(1,get_global_mouse_position())

func _on_StartBeginPlay_input_event(viewport, event, shape_idx):
	if Input.is_action_pressed("LMC"):
		beginPlayLineMade = true
