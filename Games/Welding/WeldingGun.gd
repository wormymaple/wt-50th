extends Sprite

export var move_curve: Curve
export var move_pos: float
export var move_time_max: float
var move_time = 0.0
var start_y

# Called when the node enters the scene tree for the first time.
func _ready():
	start_y = global_position.y

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	move_time += delta
	if move_time > move_time_max:
		move_time -= move_time_max
	global_position = Vector2(global_position.x, move_curve.interpolate(move_time / move_time_max) * move_pos + start_y)
