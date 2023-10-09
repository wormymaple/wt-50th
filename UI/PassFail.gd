extends RichTextLabel

export var root: NodePath

export var curve: Curve
export var max_time: float
var time: float

export var start_y: float
export var shift_y: float

var showing = false
var called_half = false

export var background: NodePath

func _process(delta):
	if !showing:
		return
	
	time += delta
	if time > max_time / 2 and not called_half:
		get_node(root).new_scene()
	elif time > max_time:
		showing = false
		time = max_time
	
	var interp = curve.interpolate(time / max_time)
	modulate = Color(1, 1, 1, interp)
	get_node(background).modulate = Color(1, 1, 1, interp)
	rect_position = Vector2(rect_position.x, start_y + shift_y * interp)

func show_pass():
	showing = true
	called_half = false
	bbcode_text = "[center][color=green]PASSED!"

func show_fail():
	print("fail")
	showing = true
	called_half = false
	bbcode_text = "[center][color=red]FAILED!"
