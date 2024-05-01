extends Control

var ScrollSpeed = 1.5

func _process(_delta):
	if Input.is_action_pressed("speed_up"):
		ScrollSpeed = 3
	else:
		ScrollSpeed = 1.5
	
	if $Credits.rect_position.y > -2900:
		$Credits.rect_position.y += - ScrollSpeed
	

func _on_Button_pressed():
	if get_tree().change_scene("res://MainStuff/Scenes/Title screen.tscn") != OK:
		print("An unexpected error occured when trying to switch to the title screen scene")
