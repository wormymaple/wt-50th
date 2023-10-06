extends Node2D

func _ready():
	pass # Replace with function body.



func _on_CheckButton_pressed():
	checkifwin()
	pass # Replace with function body.

func checkifwin():
	if $IWant.nailsColorIWant[0] == $YouPaint.colorsYouPainted[0] && $IWant.nailsColorIWant[1] == $YouPaint.colorsYouPainted[1] && $IWant.nailsColorIWant[2] == $YouPaint.colorsYouPainted[2] && $IWant.nailsColorIWant[3] == $YouPaint.colorsYouPainted[3] && $IWant.nailsColorIWant[4] == $YouPaint.colorsYouPainted[4]:
		print('win')
	else:
		print('NO WIN')
	pass
