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
	label.push_color(Color(70, 213, 80, 255))
	label.text = "Stop in the Green!"
	# label.pop()

func _process(delta):
	if (get_node(hammer).win_game == true):
		label.push_color(Color(70, 213, 80, 255))
		label.text = "You Win!"
		# label.pop() # if (get_node(hammer).dot_in_green == true):
		# print("yeah")
	# print(win_game)
	
func _on_Button_pressed ():
	if (get_dot == true):
		get_dot = false
		if (get_node(hammer).dot_in_green == true):
			secondtext = true
		else:
			label.push_color(Color(227, 40, 40, 255))
			label.text = "You Lose!"
			# label.pop()
	if (secondtext == true):
		label.push_color(Color(248, 230, 35, 255))
		label.text = "Hammer the Nail!"
		label.pop()

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
