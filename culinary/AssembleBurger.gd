extends TextureButton
var label : String
var dropped_on_target: bool = false

var okToDrop: bool = false;

onready var DRAGPREVIEW = preload("res://culinary/DragPreview.tscn")

signal burgerItemAdd(itemToAdd)

func _ready():
	pass # Replace with function body.

# warning-ignore:unused_argument
func get_drag_data(position):
	var info = self
	
	var dragPreview = DRAGPREVIEW.instance()
	dragPreview.texture = texture_normal
	add_child(dragPreview)
	return info
	
# warning-ignore:unused_argument
# warning-ignore:unused_argument
func can_drop_data(position, data):
	if self.get_groups()[0] == 'BurgerMaker':
		return true
	else:
		return false

# warning-ignore:unused_argument
func drop_data(position, data):
	emit_signal("burgerItemAdd", data.get_groups()[0])
	#print(data.get_groups()[0])
	data.queue_free()
	pass
