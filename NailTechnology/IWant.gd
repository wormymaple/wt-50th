extends Node2D

var rng = RandomNumberGenerator.new()

var colorsIMightWant = ['red', 'blue', 'yellow', 'green']
var nailsColorIWant = []

signal setnail(color)

func _ready():
	rng.randomize()
	for i in range(5):
		var k = rng.randi_range(0, colorsIMightWant.size() - 1)
		nailsColorIWant.push_back(colorsIMightWant[k])
		print(nailsColorIWant[i])
	emit_signal("setnail", nailsColorIWant)
	
