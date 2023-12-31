extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

export var total_fade: NodePath


# Called when the node enters the scene tree for the first time.
func _ready():
	get_node(total_fade).modulate.a = 1
	pass # Replace with function body.


func _process(delta):
	if get_node(total_fade).modulate.a > 0:
		get_node(total_fade).modulate.a -= delta


func _on_Play_pressed():
	get_tree().change_scene("res://GameScene.tscn")

#Mobile does not need to a quit game button
#func _on_Quit_pressed():
	#get_tree().quit


func _on_Credits_pressed():
	get_tree().change_scene("res://Game Assets/UserInterface/Scenes/GodotCredits.tscn")


func _on_Settings_pressed():
	#get_tree().change_scene(""res://Game Assets/UserInterface/Scenes/settings_menu.tscn"")
	#load("res://Game Assets/UserInterface/Scenes/settings_menu.tscn")
	pass
	

