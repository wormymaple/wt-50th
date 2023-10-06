extends Sprite

var nailNumber

func _ready():
	if self.get_groups()[0] == 'one':
		nailNumber = 0
	elif self.get_groups()[0] == 'two':
		nailNumber = 1
	elif self.get_groups()[0] == 'three':
		nailNumber = 2
	elif self.get_groups()[0] == 'four':
		nailNumber = 3
	elif self.get_groups()[0] == 'five':
		nailNumber = 4

func _on_IWant_setnail(color):
	if color[nailNumber] == 'red':
		self_modulate = Color(255,0,0,255)
	elif color[nailNumber] == 'blue':
		self_modulate = Color(0,0,255,255)
	elif color[nailNumber] == 'green':
		self_modulate = Color(0,255,0,255)
	elif color[nailNumber] == 'yellow':
		self_modulate = Color(0,255,255,255)
	pass # Replace with function body.
