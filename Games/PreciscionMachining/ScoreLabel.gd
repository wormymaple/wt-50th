extends RichTextLabel

export var show_time_max = 0.0
export var start_pos = 0
export var shift_pos = 0
var show_time = 0.0

export(Curve) var show_curve
export var sheet: NodePath
export var score_cuttoff: int

#This is to send a signal to the scene root so the game can know if you passed or not.
signal passed
signal failed


var showing = false

func _ready():
	pass
	rect_global_position = Vector2(rect_global_position.x, start_pos)

func set_score(score):
	var passed = score_cuttoff < score
	print(score)
	if passed:
		bbcode_text += "[color=green]PASSED!"
		emit_signal("passed")
	else:
		bbcode_text += "[color=red]FAILED!"
		get_node(sheet).color = Color(0.1, 0, 0, 1)
		emit_signal("failed")
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
	rect_global_position = Vector2(rect_global_position.x, start_pos + shift_pos * interpolation)
	modulate = Color(1, 1, 1, interpolation)
	
	get_node(sheet).modulate = Color(1, 1, 1, interpolation)
	
