extends Line2D

#export(Array, Vector2) var shape_points = []
export(Array, Vector2) var shape_points = []


func _ready():
	for point in shape_points:
		add_point(point)
		print("Added Points")
	#add_point(shape_points)
