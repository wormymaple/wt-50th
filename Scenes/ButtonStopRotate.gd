extends Button

# var rotation_speed = Node2D.rotation

func _ready():
	var button = Button.new()
	button.text = "Stop"
	button.connect("pressed", self, "_button_pressed")
	add_child(button)

func _button_pressed():
	# rotation_speed = 0
	print("rotation should stop")
