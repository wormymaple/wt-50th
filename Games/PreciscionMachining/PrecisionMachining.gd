extends Control

var passed = null
var failed = null
var CanDraw = true
var IsDrawing = false
var PreviousPoint := Vector2.INF
var MinimumDistanceBetweenPoints = 15
var FirstPoint: Vector2
var SimpleThreshold = .98
var OverlayFadeVar = 0
var StartingFade = false
var PossibleOutlines = ["House", "Octagon", "Hammer", "Parallelogram", "Original"]
onready var ChosenOutline = $OriginalDesign #Starts it off as this, but will not be this
var MaxScore = 5 #This is leniency. The higher, the more lenient

onready var DrawLine = $DrawLine

func _ready(): #Choose one outline
	$Nozzle.hide()
	
	randomize()
	var RandomOutline = PossibleOutlines[randi() % PossibleOutlines.size()]
	#var RandomOutline = "Parallelogram"
	
	if RandomOutline == "House":
		ChosenOutline = $"HouseDesign"
	if RandomOutline == "Octagon":
		ChosenOutline = $"OctagonDesign"
	if RandomOutline == "Hammer":
		ChosenOutline = $"HammerDesign"
	if RandomOutline == "Parallelogram":
		ChosenOutline = $RectangleDesign
	if RandomOutline == "Original":
		ChosenOutline = $"OriginalDesign"
	#ChosenOutline = PossibleOutlines[randi() % PossibleOutlines.size()]
	#print(ChosenOutline)
	#if ChosenOutline == "Original":
	ChosenOutline.visible = true #show()

func _process(delta):
	var MousePosition = get_local_mouse_position()
	
	if Input.is_action_just_pressed("LeftClick") and CanDraw:
		CanDraw = false #Prevents the player from drawing again in this attempt
		IsDrawing = true
		DrawLine.add_point(MousePosition)
		FirstPoint = MousePosition
		PreviousPoint = MousePosition
	
	if IsDrawing and Input.is_action_pressed("LeftClick"): #Is active if it is still held down
		#print("Currently drawing!")
		$Particles.emitting = true
		$Particles.position = MousePosition
		$Nozzle.show()
		$Nozzle.position = MousePosition
		$Nozzle.rotation = Vector2(952, 328).angle_to_point(MousePosition) - 90 #Vector2.ZERO.angle_to_point(MousePosition) - 90
		
		var DistanceToLastPoint = MousePosition.distance_to(PreviousPoint)
		if (DistanceToLastPoint > MinimumDistanceBetweenPoints):
			DrawLine.add_point(MousePosition)
			PreviousPoint = MousePosition #Makes this new point the PreviousPoint
		
	if Input.is_action_just_released("LeftClick") and IsDrawing: #This stuff is done when the player is done drawing
		IsDrawing = false
		$Nozzle.hide()
		$Particles.emitting = false
		
		for point in DrawLine.points: # Disqualifies the player if they draw out of bounds
			#print(point)
			if point.x < 700 or point.x > 1208 or point.y < 100 or point.y > 576:
				failed = true
				print("Player went out of bounds")
				return #Quits out early so it doesn't do redundant checks
		
		#This checks the score
		#print(CreatedPoints)
		var Total = 0.0
		var ReferencePoints = ChosenOutline.points
		#print(ChosenOutline.points)
		for ReferencePoint in ReferencePoints: #For every reference point...
			#print(ReferencePoint)
			#print(CreatedPoints[0])
			var ClosestPoint = DrawLine.points[0] # Sets the first closest point to the first point
			for point in DrawLine.points:
				#print(point)
				if ReferencePoint.distance_to(point) < ReferencePoint.distance_to(ClosestPoint):
					ClosestPoint = point #If this point was closer than the previous point, this is the new closest point
			#print(ClosestPoint)
			#print("Ref: ", ReferencePoint)
			#print(ReferencePoint.distance_to(ClosestPoint))
			Total += ReferencePoint.distance_to(ClosestPoint) # The less accurate the player was, the bigger this is
		#print(position)
		#print(ChosenOutline.position)
		#print(Total)
		Total = MaxScore - int(Total/ len(DrawLine.points)) # Divides the "unaccuracy" amount by the amount of points, which makes diificulty scale with shapes with more points
		
		#set_point_position(len(points) - 1, points[0])
		var SimplifiedPoints = simplify_shape(DrawLine.points, 1)
		DrawLine.clear_points() # This clears the old points so they don't show up with the new points
		for point in SimplifiedPoints:
			DrawLine.add_point(point) # gives the line it's new simplified points
				
		$FillArea.polygon = DrawLine.points # Wonder if this will break
		StartingFade = true
		$FadeOverlay.show()
		
		
		print("Total: ", Total)
		if Total > 0: # Player passes if so 
			passed = true
			#print("Passed!")
		else:
			failed = true
			#print("Failed!")
	
	#Make the FadeOverlay start fading in
	if StartingFade: # Makes the overlay fade in
		if OverlayFadeVar < 1:
			OverlayFadeVar += delta
			$FadeOverlay.modulate.a = OverlayFadeVar

func simplify_shape(CreatedPoints, TimesToDo): #This makes the line drop unnecesary points
	if len(CreatedPoints) < 3:
		return CreatedPoints
	var NewPoints = [CreatedPoints[0]]
	for i in range(1, len(CreatedPoints) - 1):
		var point = CreatedPoints[i]
		var d1 = point.direction_to(CreatedPoints[i - 1])
		var d2 = point.direction_to(CreatedPoints[i + 1])
		
		if abs(d1.dot(d2)) < SimpleThreshold: #Man I wish I knew how this code worked
			NewPoints.append(point)
			
	NewPoints.append(CreatedPoints[-1])
	
	#print(TimesToDo)
	if (TimesToDo > 0):
		return simplify_shape(NewPoints, TimesToDo - 1) #The eventual output will be the shape simplified again
	else:
		return NewPoints
		
