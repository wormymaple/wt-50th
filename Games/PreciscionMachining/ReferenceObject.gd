extends Line2D


export(Array, Vector2) var shape_points = []

# Called when the node enters the scene tree for the first time.
func _ready():
	for point in shape_points:
		add_point(point)
	add_point(shape_points[0])


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
