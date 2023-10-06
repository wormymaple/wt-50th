extends Node2D

var selectedColor

var colorsYouPainted = ['test', 'test', 'test', 'test', 'test']

func _ready():
	pass # Replace with function body.

func _on_PaintColors_colorChange(color):
	selectedColor = color
	pass

func paintTime(nail):
	print(selectedColor)
	if(selectedColor == 'red'):
		nail.modulate = Color(255, 0, 0, 255)
	if(selectedColor == 'green'):
		nail.modulate = Color(0, 255, 0, 255)
	if(selectedColor == 'blue'):
		nail.modulate = Color(0, 0, 255, 255)
	if(selectedColor == 'yellow'):
		nail.modulate = Color(0, 255, 255, 255)
	if(selectedColor == 'Null'):
		nail.modulate = Color(255,255,255,255)

func _on_NailYouColor1_pressed():
	colorsYouPainted[0] = selectedColor
	paintTime($NailYouColor1)

func _on_NailYouColor2_pressed():
	colorsYouPainted[1] = selectedColor
	paintTime($NailYouColor2)


func _on_NailYouColor3_pressed():
	colorsYouPainted[2] = selectedColor
	paintTime($NailYouColor3)


func _on_NailYouColor4_pressed():
	colorsYouPainted[3] = selectedColor
	paintTime($NailYouColor4)


func _on_NailYouColor5_pressed():
	colorsYouPainted[4] = selectedColor
	paintTime($NailYouColor5)
