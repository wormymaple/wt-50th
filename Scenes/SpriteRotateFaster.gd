extends KinematicBody2D

export (float) var rotation_speed = -6
export (bool) var is_rotating = true
export (bool) var dot_in_range = true

#func get_input():
	#rotation_dir = 0
	#if Input.is_action_pressed("right"):
		#rotation_dir += 1
	#if Input.is_action_pressed("left"):
		#rotation_dir -= 1

func _physics_process(delta):
	#get_input()
	if (is_rotating == true):
		rotation += 1 * rotation_speed * delta
	elif (is_rotating == false):
		rotation += 0


func _on_Button_button_down():
	is_rotating = false
	if (dot_in_range == true):
		print("hooray")
	# print("stop pls?")


func _on_Area2D_area_entered(area):
	dot_in_range = true


func _on_Area2D_area_exited(area):
	dot_in_range = false
