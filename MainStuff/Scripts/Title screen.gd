extends Control

export var total_fade: NodePath

func _ready():
	$TotalFade.visible = true

func _process(delta):
	if $TotalFade.modulate.a > 0:
		$TotalFade.modulate.a -= delta
	else:
		$TotalFade.visible = false

func _on_Play_pressed() -> void:
	if get_tree().change_scene("res://MainStuff/Scenes/GameScene.tscn") != OK:
		print("An unexpected error occured when trying to switch to the title screen scene")
func _on_Credits_pressed() -> void:
	if get_tree().change_scene("res://MainStuff/Scenes/Credits.tscn") != OK:
		print("An unexpected error occured when trying to switch to the title screen scene")
func _on_Quit_Game_pressed():
	get_tree().quit()
