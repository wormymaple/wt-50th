extends Node2D

#Thesse variables are in the scene root because I don't know how to get the variables of the child of a scene that are instanced.
var passed = null
var failed = null
var get_ref = false
# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Score_failed():
	failed = true
	get_ref = true


func _on_Score_passed():
	passed = true
	get_ref = true
