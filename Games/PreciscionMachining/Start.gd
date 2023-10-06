extends Polygon2D

export var fade_time_max: float
var fade_time = 0.0

export var disappear_curve: Curve
var fading

func start():
	fading = true
	
func _process(delta):
	if !fading:
		return
	
	fade_time += delta
	if fade_time >= fade_time_max:
		fade_time = fade_time_max
		fading = false
	
	modulate = Color(1, 1, 1, 1 - disappear_curve.interpolate(fade_time / fade_time_max))

