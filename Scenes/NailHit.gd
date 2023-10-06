extends KinematicBody2D
var nailhits = 0

# export var dot: NodePath
var dot_in_green = false
export var button: NodePath
onready var timer = $AnimTimer
onready var hammup = $HammerUp
onready var hammdown = $HammerDown
onready var nail = $Nail
var ready_to_hit = true
var win_game = false

# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	timer.connect("timeout", self, "_on_Timer_timeout")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	# print(get_node(dot).dot_in_green)


func _on_Button_button_down():
	if (dot_in_green):
		if (nailhits < 6 and ready_to_hit):
			hammup.visible = true
			if (nailhits > 0):
				ready_to_hit = false
				hammup.visible = false
				hammdown.visible = true
				timer.start(0.3)
			nail.rotation += 45
			nailhits += 1
		if (nailhits == 6):
			win_game = true
			# print ("you win")

func _on_Timer_timeout ():
	hammdown.visible = false
	hammup.visible = true
	ready_to_hit = true
