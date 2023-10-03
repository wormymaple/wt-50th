extends RigidBody2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
#func _ready():
	#pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_box_input_event(viewport, event, shape_idx):
	if	event is InputEventMouseButton and event.pressed and event.button_index == BUTTON_LEFT:
		print ('lol it works')
		queue_free()
#onready var box = preload("res://box.tscn")

func _ready():
	new_box()
	
func new_box():
	var New_box = box.instance()
	add_child(New_box)
