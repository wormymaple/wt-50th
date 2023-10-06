extends Sprite


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


var label: String
var dropped_on_target: bool = false



func _ready():
	add_to_group("DRAGGABLE")
	pass

func get_drag_data(position: Vector2):
	var slot = get_parent().get_name()

	var data = {}
	data["origin_node"] = self
	data["origin_slot"] = slot
	data["origin_texture_normal"] = texture_normal
	data["origin_texture_pressed"] = texture_pressed
	
	var dragPreview = DRAGPREVIEW.instance()
	dragPreview.texture = texture_normal
	add_child(dragPreview)

	return data



