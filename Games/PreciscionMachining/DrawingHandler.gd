extends Line2D

var drawing = false
var just_released = false

export var min_finish_dist = 0
export var simp_threshold = 0.0

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if drawing:
		var mouse_pos = get_global_mouse_position()
		add_point(mouse_pos)
		
	elif just_released:
		just_released = false
		
		var dist = points[-1].distance_to(points[0])
		if dist <= min_finish_dist:
			add_point(points[0])
		else:
			clear_points()

func _input(event):
	if event is InputEventMouseButton:
		if event.button_index == BUTTON_LEFT:
			drawing = event.pressed
			if (!drawing):
				just_released = true
			else:
				clear_points()

func simplify_shape():
	
