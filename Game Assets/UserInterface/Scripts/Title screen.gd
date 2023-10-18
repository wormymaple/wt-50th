extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

export var total_fade: NodePath


# Called when the node enters the scene tree for the first time.
func _ready():
	#$TotalFade.modulate.a = 1
	$TotalFade.visible = true
	pass # Replace with function body.


func _process(delta):
	if $TotalFade.modulate.a > 0:
		$TotalFade.modulate.a -= delta
	else:
		$TotalFade.visible = false


func _on_Play_pressed() -> void:
	get_tree().change_scene("res://GameScene.tscn")

#Mobile does not need to a quit game button
#func _on_Quit_pressed():
	#get_tree().quit


func _on_Credits_pressed() -> void:
	get_tree().change_scene("res://Game Assets/UserInterface/Scenes/GodotCredits.tscn")


func _on_Settings_pressed():
	#get_tree().change_scene(""res://Game Assets/UserInterface/Scenes/settings_menu.tscn"")
	#load("res://Game Assets/UserInterface/Scenes/settings_menu.tscn")
	pass
	

