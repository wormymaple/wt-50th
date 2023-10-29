extends Control
func _process(_delta):
	$Credits.rect_position.y += - 1
func _on_Button_pressed():
	if get_tree().change_scene("res://MainScenes/Scenes/Title screen.tscn") != OK:
		print("An unexpected error occured when trying to switch to the title screen scene")
