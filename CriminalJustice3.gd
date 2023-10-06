extends RigidBody2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
#func _ready():
	#pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):



func _on_Box_input_event(_viewport, event, _shape_ind):
		if event is InputEventMouseButton and event.pressed and event.button_index == BUTTON_LEFT:
			print ('Correct')
			hide()


func _on_RigidBody2D_input_event(viewport, event, shape_idx):
	pass # Replace with function body.
