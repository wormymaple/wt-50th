extends KinematicBody2D

export (float) var rotation_speed = -6.0
export (bool) var is_rotating = true
var dot_in_range = true
var dot_in_green = false
export var hammer: NodePath

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
	if (!dot_in_green):
		is_rotating = false
		if (dot_in_range == true):
			dot_in_green = true
			print("hooray")
	get_node(hammer).dot_in_green = dot_in_green
	# print("stop pls?")


func _on_Area2D_area_entered(_area):
	dot_in_range = true


func _on_Area2D_area_exited(_area):
	dot_in_range = false
