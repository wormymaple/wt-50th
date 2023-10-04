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


func _on_box_input_event(_viewport, event, _shape_idx):
	if	event is InputEventMouseButton and event.pressed and event.button_index == BUTTON_LEFT:
		print ('lol it works')
		queue_free()
onready var box = load("res://box.tscn")

func _ready():
	new_box()
	
func new_box():
	var new_box = box.instance()
	add_child(new_box)
func select():
	yield(get_tree().create_timer(0.1),"timeout")
	if not flagged and not selected:
		selected = true 
		if mie:
			set_texture(mine_block)
			
			else:
				var mines = cheack_neighbors()
				match mines:
					0:
			set_texture(clear_blocked)
			select_neighbors()
