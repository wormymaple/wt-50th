extends RichTextLabel


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
export var show_time_max = 0.0
export var start_pos = 0
export var shift_pos = 0
var show_time = 0.0

export(Curve) var show_curve

var showing = false

func set_score(score):
	bbcode_text = "[center]Score: " + str(score)
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
	rect_global_position = Vector2(-100, start_pos + shift_pos * interpolation)
	modulate = Color(1, 1, 1, interpolation)
	
