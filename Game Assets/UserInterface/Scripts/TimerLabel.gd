extends Label

var use_milliseconds = true
#onready var countdown := $Timer
var ElapsedTime: float = 0.0
var ElapsedDelta = 0
var CurrentSecondThreshold = 0.1
	#I need to make the time increase consistently. Delta is the time elapsed between frames.
	#If i can get delta to count time between frames and activate at certain points, it will work
func _process(delta):
	ElapsedDelta += delta
	if ElapsedDelta >= CurrentSecondThreshold:
		ElapsedTime = ElapsedTime + 0.1
		#print("time increased!")
		CurrentSecondThreshold += 0.1
	#print(ElapsedDelta)
	#print(ElapsedTime)
	#print(CurrentSecondThreshold)
	#print(delta)
	var minutes := ElapsedTime / 60
	var seconds := fmod(ElapsedTime, 60)
	var milliseconds := fmod(ElapsedTime, 1) * 100
	text = "%02d:%02d:%02d" % [minutes, seconds, milliseconds]
