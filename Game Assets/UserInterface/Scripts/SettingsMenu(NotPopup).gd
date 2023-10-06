extends Node

# Audio Settings
onready var MasterSlider = $SettingsMenu/SettingsTabs/Audio/MarginContainer/AudioSettings/HBoxContainer/MasterSlider
onready var MusicSlider = $SettingsMenu/SettingsTabs/Audio/MarginContainer/AudioSettings/HBoxContainer/MusicSlider
onready var SFXSlider = $SettingsMenu/SettingsTabs/Audio/MarginContainer/AudioSettings/HBoxContainer/SFXSlider

func _ready():
	pass
	
func _on_MasterSlider_value_changed(value):
	GlobalSettings.update_master_vol(value)
	
func _on_MusicSlider_value_changed(value):
	pass # Replace with function body.


func _on_Button_pressed():
	get_tree().change_scene("res://Game Assets/UserInterface/Scenes/Title screen.tscn")
