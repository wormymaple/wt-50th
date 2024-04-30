extends Control

var ScrollSpeed = 1

func _process(_delta):
	if Input.is_action_pressed("ui_down"):
		ScrollSpeed = 5
	else:
		ScrollSpeed = 1
	
	if $Credits.rect_position.y > -3416:
		$Credits.rect_position.y += - ScrollSpeed
	

func _on_Button_pressed():
	if get_tree().change_scene("res://MainStuff/Scenes/Title screen.tscn") != OK:
		print("An unexpected error occured when trying to switch to the title screen scene")
