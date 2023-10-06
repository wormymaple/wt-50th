extends Button

onready var label = $RichTextLabel
export var hammer: NodePath
var get_dot = true
var secondtext = false

# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	connect("pressed", self, "_on_Button_pressed")
	label.text = "Stop in the green!"

func _process(delta):
	if (get_node(hammer).win_game == true):
		label.text = "You win!" # if (get_node(hammer).dot_in_green == true):
		# print("yeah")
	# print(win_game)
	
func _on_Button_pressed ():
	if (get_dot == true):
		if (get_node(hammer).dot_in_green == true):
			secondtext = true
			get_dot = false
	if (secondtext == true):
		label.text = "Hammer the nail!"

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
