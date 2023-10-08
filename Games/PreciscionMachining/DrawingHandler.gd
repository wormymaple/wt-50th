extends Line2D

var drawing = false
var just_released = false
var finished_drawing = false

export var min_finish_dist = 0
export var simp_threshold = 0.0
export var min_draw_dist = 0
export var max_score = 0

export var start_pos: Vector2
export var start_dist: float

export var ref_object: NodePath
export var score_indicator: NodePath
export var water_particles: NodePath
export var fill: NodePath
export var start: NodePath
export var water_nozzle: NodePath
export var start_object: NodePath

var prev_point := Vector2.INF

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if finished_drawing:
		return
	
	if drawing:
		var mouse_pos = get_local_mouse_position()
		print(mouse_pos)
		var dist = mouse_pos.distance_to(prev_point)
		if (dist > min_draw_dist):
			add_point(mouse_pos)
			prev_point = mouse_pos
			
		get_node(water_particles).position = mouse_pos
		
		var nozzle = get_node(water_nozzle)
		nozzle.position = mouse_pos
		nozzle.rotation = Vector2.ZERO.angle_to_point(mouse_pos) - 90
		
	elif just_released:
		just_released = false
		
		var dist = points[-1].distance_to(points[0])
		if dist <= min_finish_dist:
			set_point_position(len(points) - 1, points[0])
			var simp_points = simplify_shape(points, 4)
			clear_points()
			for point in simp_points:
				add_point(point)
				
			get_node(fill).polygon = points
			
			var score = max_score - int(check_points(points))
			if (score < 0):
				score = 0
			
			get_node(score_indicator).set_score(score)
			get_node(ref_object).modulate = Color(1, 1, 1, 0.2)
		else:
			get_node(score_indicator).set_score(0)
		
		finished_drawing = true

func _input(event):
	if (finished_drawing):
		return
	
	if event is InputEventMouseButton:
		if event.button_index == BUTTON_LEFT:
			if event.pressed:
				var dist = get_global_mouse_position().distance_to(get_node(start_object).global_position)
				if (dist < start_dist):
					drawing = true
					get_node(water_particles).emitting = true
					get_node(start).start()
					clear_points()
			elif drawing:
				drawing = false
				just_released = true
				get_node(water_particles).emitting = false

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

func check_points(in_points):
	var total = 0.0
	var ref_points = get_node(ref_object).points
	for ref_point in ref_points:
		var closest_point = in_points[0]
		for point in in_points:
			if ref_point.distance_to(point) < ref_point.distance_to(closest_point):
				closest_point = point
		
		total += ref_point.distance_to(closest_point)
	
	return total / len(in_points)
