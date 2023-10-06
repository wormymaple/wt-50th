extends Node2D


func ready() -> void:
	$Node2D/knob.connect("turnedKnob", self, "turnKnob")
	
func turnKnob(f:float) -> void:
	$Icon.position.up = f
