extends Sprite

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _process(_delta):
	global_position = get_global_mouse_position()
	
	if Input.is_action_just_released("LeftMouse"):
		queue_free()
	pass
