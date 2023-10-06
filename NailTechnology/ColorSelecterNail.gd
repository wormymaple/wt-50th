extends Node2D

var colorSelect = "none"

signal colorChange(color)

func _ready():
	pass


func _on_RedColor_button_up():
	colorSelect = 'red'
	emit_signal("colorChange", colorSelect)
	print(colorSelect)
	pass


func _on_BlueColor_button_up():
	colorSelect = 'blue'
	emit_signal("colorChange", colorSelect)
	print(colorSelect)
	pass


func _on_GreenColor_button_up():
	colorSelect = 'green'
	emit_signal("colorChange", colorSelect)
	print(colorSelect)
	pass


func _on_YellowColor_button_up():
	colorSelect = 'yellow'
	emit_signal("colorChange", colorSelect)
	print(colorSelect)
	pass
