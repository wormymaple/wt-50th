extends Line2D

var drawing = false
var just_released = false

export var min_finish_dist = 0
export var simp_threshold = 0.0
export var min_draw_dist = 0

var prev_point := Vector2.INF

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if drawing:
		var mouse_pos = get_global_mouse_position()
		var dist = mouse_pos.distance_to(prev_point)
		if (dist > min_draw_dist):
			add_point(mouse_pos)
			prev_point = mouse_pos
		
	elif just_released:
		just_released = false
		
		var dist = points[-1].distance_to(points[0])
		if dist <= min_finish_dist:
			add_point(points[0])
			var simp_points = simplify_shape(points, 4)
			clear_points()
			for point in simp_points:
				add_point(point)
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

func simplify_shape(in_points, n):
	var new_points = [in_points[0]]
	for i in range(1, len(in_points) - 1):
		var point = in_points[i]
		var d1 = point.direction_to(in_points[i - 1])
		var d2 = point.direction_to(in_points[i + 1])
		
		if abs(d1.dot(d2)) < simp_threshold:
			new_points.append(point)
			
	new_points.append(in_points[-1])
	if len(new_points) < 3:
		return in_points
	
	if (n > 0):
		return simplify_shape(new_points, n - 1)
	else:
		return new_points
