extends Sprite

const SPEED = 300 # pixel per second
const MAX_TRACKING_DISTANCE = 400 # pixel

var screen_touch = false
var path = []

func _unhandled_input(event):
	if event is InputEventMouseButton and event.button_index == BUTTON_LEFT:
		screen_touch = event.pressed
		if screen_touch:
			add_to_path(event.global_position)
	elif event is InputEventMouseMotion and screen_touch:
		add_to_path(event.global_position)
		
		
func add_to_path(position):
	var distance = global_position.distance_to(position)
	if distance > MAX_TRACKING_DISTANCE:
		path.clear()
	path.push_back(position)
	
	
func _physics_process(delta):
	if path.empty(): return
	var next_pos = path.front()
	
	var direction = global_position.direction_to(next_pos)
	var distance = global_position.distance_to(next_pos)
	var reach = SPEED * delta
	
	if distance > reach:
		# next_pos is out of reach in this frame
		# => move as far as possible towards it!
		global_position += direction * reach
	elif distance < reach:
		# next_pos is reachable in this frame
		# => move there and remove it from the path
		while distance < reach:
			global_position += direction * distance
			reach -= distance
			path.pop_front()
			
			# check if theres another position in the path
			# that we can already move towards
			if path.empty(): return
			next_pos = path.front()
			direction = global_position.direction_to(next_pos)
			distance = global_position.distance_to(next_pos)
