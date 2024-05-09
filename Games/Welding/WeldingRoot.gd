extends Control

#Variables:
var passed = null
var failed = null

var PossibleShapes = ["Wavy", "Curvy", "Mountain"]
var RandomShape = null
var ChosenShape = null
var RightHalfChosenShape = null

var WeldingStage = false
var ButtonPressed = null
var OutputYet = false
var PieceSlideInPhase = false
var CanStartDrawing = true
var IsNotHoldingLeftClick = true
var IsWelding = false
var StartingFade = false
var PieceSeparation = 669
var FirstPoint = null
var PreviousPoint = null
var MinimumDistanceBetweenPoints = 5
var ChosenOutline = null
var ScoreLeniancy = 12

var PossibleFrames = [0, 1, 2, 3]
var PreviousFrame = 1

# Called when the node enters the scene tree for the first time.
func _ready():
	randomize()
	RandomShape = PossibleShapes[randi() % PossibleShapes.size()] # Gets a random sheet to weld
	print(RandomShape)
	if RandomShape == "Wavy":
		ChosenShape = $WavyMetalPiece
		RightHalfChosenShape = $RightWavyMetalPiece
		ChosenOutline = $WavyGuideline
	if RandomShape == "Curvy":
		PieceSeparation = 675 # The wavy piece needs to be farther away so you can see the seams better
		ChosenShape = $CurvyMetalPiece
		RightHalfChosenShape = $RightCurvyMetalPiece
		ChosenOutline = $CurvyGuideline
	if RandomShape == "Mountain":
		ChosenShape = $MountainyMetalPiece
		RightHalfChosenShape = $RightMountainyMetaPiece
		ChosenOutline = $MountainyGuideline
	
	#ChosenOutline.visible = true
	ChosenShape.visible = true
	#$FadeOverlay.modulate.a = 0
	$Particles.emitting = false
	$ShinyTexture.visible = false
	$ShinyTexture.modulate.a = 0

func _process(delta):
	if passed and !OutputYet:
		print("Passed!")
		$WeldingLine.visible = false
		#$ShinyTexture.visible = true
		OutputYet = true
	if failed and !OutputYet:
		print("Failed!")
		OutputYet = true
	
	#var EaseTest = ease(831, -1)
	#print(EaseTest)
	
	
	
	
	if PieceSlideInPhase:
		$Tween.interpolate_property(RightHalfChosenShape, "rect_position",
			Vector2(1500, 96), Vector2(PieceSeparation, 96), 1, # Vector2(1500, 0), Vector2(PieceSeparation, 0), 1,
			Tween.TRANS_CUBIC, Tween.EASE_OUT)
		$Tween.start()
		PieceSlideInPhase = false
		WeldingStage = true
		
	#	if RightHalfChosenShape.rect_position.x > PieceSeparation:
	#		RightHalfChosenShape.rect_position.x -= 10
	#	else:
	#		RightHalfChosenShape.rect_position.x = PieceSeparation
	#		PieceSlideInPhase = false
	#		WeldingStage = true
	
	# Second half of minigame: Welding the pieces together
	var MousePosition = get_local_mouse_position()
	
	if WeldingStage:
		$WeldingGun.position = Vector2(MousePosition.x + 35, MousePosition.y + 88)
	
	if Input.is_action_just_pressed("LeftClick") and WeldingStage and CanStartDrawing: #The mouse was clicked for the first time
		CanStartDrawing = false #Prevents the player from drawing again in this attempt
		IsWelding = true
		$WeldingGun.animation = "On"
		$WeldingGun.show()
		
		$WeldingLine.add_point(MousePosition) # Adds the first initial point
		FirstPoint = MousePosition
		PreviousPoint = MousePosition
		
	if IsWelding and WeldingStage and Input.is_action_pressed("LeftClick"): #Is active as long is still held down
		#print("Currently drawing!")
		
		$Particles.emitting = true
		$Particles.position = MousePosition
		
		if (MousePosition.distance_to(PreviousPoint) > MinimumDistanceBetweenPoints):
			$WeldingLine.add_point(MousePosition)
			PreviousPoint = MousePosition #Makes this new point the PreviousPoint
		
	if Input.is_action_just_released("LeftClick") and IsWelding: #This stuff is done when the player is done drawing
		IsWelding = false
		$WeldingGun.hide()
		$WeldingGun.animation = "Normal"
		$Particles.emitting = false
		for point in $WeldingLine.points: # Disqualifies the player if they draw out of bounds
			#print(point)
			if point.x < 600 or point.x > 1100 or point.y < 25 or point.y > 650:
				failed = true
				print("You went out of bounds")
				return #Quits out early so it doesn't do redundant checks
		
		#This checks the score
		#print(CreatedPoints)
		var Total = 0.0
		var ReferencePoints = ChosenOutline.points
		#print(ChosenOutline.points)
		for ReferencePoint in ReferencePoints: #For every reference point...
			#print(ReferencePoint)
			#print(CreatedPoints[0])
			var ClosestPoint = $WeldingLine.points[0] # Sets the first closest point to the first point
			for point in $WeldingLine.points:
				#print(point)
				if ReferencePoint.distance_to(point) < ReferencePoint.distance_to(ClosestPoint):
					ClosestPoint = point #If this point was closer than the previous point, this is the new closest point
			#print(ClosestPoint)
			#print("Ref: ", ReferencePoint)
			#print(ReferencePoint.distance_to(ClosestPoint))
			Total += ReferencePoint.distance_to(ClosestPoint) # The less accurate the player was, the bigger this is
		#print(position)
		#print(ChosenOutline.position)
		#print("Unfiltered Total:" Total)
		Total = ScoreLeniancy - (Total/ len(ChosenOutline.points)) # Divides the "unaccuracy" amount by the amount of points, which makes diificulty scale with shapes with more points
		
		
		#$FadeOverlay.show()
		print("Total: ", Total)
		if Total > 0: # Player passes if so 
			passed = true
			StartingFade = true
			$ShinyTexture.visible = true
		else:
			failed = true
	
	#Make the FadeOverlay start fading in
	if StartingFade: # Makes the overlay fade in
		#if $FadeOverlay.modulate.a < 1:
		#	$FadeOverlay.modulate.a += delta
		if $ShinyTexture.modulate.a < 1:
			$ShinyTexture.modulate.a += delta*3
		if ChosenShape.modulate.a > 0:
			ChosenShape.modulate.a -= delta
			RightHalfChosenShape.modulate.a -= delta*3




func _on_MountainyButton_pressed():
	_check_button("Mountain")
func _on_CurvyButton_pressed():
	_check_button("Curvy")
func _on_WavyButton_pressed():
	_check_button("Wavy")

func _check_button(ButtonName):
	$WavyButton.disabled = true
	$ButtonsMargin/VBoxContainer/MountainyButton.disabled = true
	$ButtonsMargin/VBoxContainer/CurvyButton.disabled = true
	if RandomShape == ButtonName:
		PieceSlideInPhase = true
		RightHalfChosenShape.show()
		RightHalfChosenShape.rect_position.x = 1500
	else:
		failed = true
