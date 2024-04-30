extends RichTextLabel

export var root: NodePath

export var curve: Curve
export var max_time: float
export var load_time: float
var time: float

export var start_y: float
export var shift_y: float

var showing = false
var called_half = false
var passed = false

export var background: NodePath

func _process(delta):
	if !showing:
		return
	
	time += delta
	if time > load_time and !called_half:
		get_node(root).new_scene(passed)
		called_half = true
	elif time > max_time:
		showing = false
		time = max_time
	
	var interp = curve.interpolate(time / max_time)
	modulate.a = interp
	$"../GameOverlay".modulate.a = interp
	rect_position = Vector2(rect_position.x, start_y + shift_y * interp)

func show_pass():
	passed = true
	
	time = 0
	showing = true
	called_half = false
	bbcode_text = "[center][color=green]PASSED!"

func show_fail():
	passed = false
	
	time = 0
	print("fail")
	showing = true
	called_half = false
	bbcode_text = "[center][color=red]FAILED!"
