extends Node2D

export (float) var rotation_speed = -1.5
export (bool) var is_rotating = true

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

func _on_Button_pressed():
	is_rotating = false
	print("stop pls?")
