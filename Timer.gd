extends Control

export (int) var seconds = 0
var dsec = 0

func _physics_process(delta):
	if seconds > 0 and dsec <= 0 :
		seconds -= 1
		dsec = 10
	
	if seconds >= 10:
		$sec.set_text(str(seconds))
	else:
		$sec.set_text("0"+(str(seconds))
	if dsec >= 10:
		$dsec.set_text(str(dsec))
	else:
		$dsec.set_text("0"+(str(dsec))



func _on_Timer_timeout():
	dsec -= 1
