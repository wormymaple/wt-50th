extends RigidBody2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_code_for_axe_to_swing_input_event(viewport, event, shape_idx):
	#pass # Replace with function body.
		if event is InputEventMouseButton and event.pressed and event.button_index == BUTTON_LEFT:
			print ('correct')
			hide()
	# hide smoke when button_ left has a event 
