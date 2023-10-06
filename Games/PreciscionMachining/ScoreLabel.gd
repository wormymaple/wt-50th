extends RichTextLabel


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
export var show_time_max = 0.0
export var start_pos = 0
export var shift_pos = 0
var show_time = 0.0

export(Curve) var show_curve
export var sheet: NodePath
export var score_cuttoff: int

var showing = false

func _ready():
	pass
	#rect_global_position = Vector2(0, start_pos)

func set_score(score):
	var passed = score_cuttoff < score
	print(score)
	if passed:
		bbcode_text += "[color=green]PASSED!"
	else:
		bbcode_text += "[color=red]FAILED!"
		get_node(sheet).color = Color(0.1, 0, 0, 1)
	showing = true


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if (!showing):
		return
	
	show_time += delta
	if (show_time >= show_time_max):
		show_time = show_time_max
		showing = false
	
	var interpolation = show_curve.interpolate(show_time / show_time_max)
	#rect_global_position = Vector2(-100, start_pos + shift_pos * interpolation)
	modulate = Color(1, 1, 1, interpolation)
	
	get_node(sheet).modulate = Color(1, 1, 1, interpolation)
	
