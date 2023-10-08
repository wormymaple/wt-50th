extends Control

onready var Credits = $Node2D

func _process(delta):
	Credits.position.y += - 1
	
func _on_Button_pressed():
	get_tree().change_scene("res://Game Assets/UserInterface/Scenes/Title screen.tscn")
