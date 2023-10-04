extends Sprite

export (float) var rotation_speed = 1.5

var rotation_dir = -1.5

#func get_input():
	#rotation_dir = 0
	#if Input.is_action_pressed("right"):
		#rotation_dir += 1
	#if Input.is_action_pressed("left"):
		#rotation_dir -= 1

func _physics_process(delta):
	#get_input()
	rotation += rotation_dir * rotation_speed * delta
