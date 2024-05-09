extends Control

onready var GameTimer = $CanvasLayer/Timer
onready var TimeLabel = $CanvasLayer/SidePanel/MarginContainer/TimeLeft
onready var TimeBar = $CanvasLayer/SidePanel/TextureProgress

var NewTimerMax = 10.5 # Starts at 10.5 seconds, will decrease by .5 each game until there is only 5 seconds left, the 10,5 accouts for the first start
var game = null
var ChangingScenes = true
var CompletedGames = 0
var TotalFadeIn = false
var GameOverlayFadeIn = false
var HasFailedIsWaitingForFadeOut = false
var ChangingTimer = false
var DidntQuitOut = true

export(Array, PackedScene) var possible_scenes


func _ready(): #This is when this scene is first loaded. It will do the first initial scene loading
	_on_TimeBetweenGames_timeout() #This should work
	#$CanvasLayer/GameOverlay.visible = false
	#$CanvasLayer/GameOverlay.modulate.a = 0
	#$CanvasLayer/PassedOrFailedText.visible = false
	$CanvasLayer/PassedOrFailedText.bbcode_text = "[center][color=yellow]Testing!"
	$CanvasLayer/PassedOrFailedText/TotalGamesText.text = "You should not see this" 
	$CanvasLayer/TotalFade.visible = true # Game will fade this out very soon anyways
	$CanvasLayer/PassedOrFailedText.rect_position.y = -250
	

func _fail():
	if DidntQuitOut:
		$CanvasLayer/GameOverTimer.start()
		$CanvasLayer/PassedOrFailedText.bbcode_text = "[center][color=red]Failed!"
		$CanvasLayer/PassedOrFailedText/TotalGamesText.text = "Games Completed:  " + str(CompletedGames)
		GameOverlayFadeIn = true
		game = null
		ChangingTimer = true
		GameTimer.stop()

func _process(delta):
	if TotalFadeIn:
		# This stuff will only activate on a game over
		$CanvasLayer/TotalFade.show()
		if $CanvasLayer/TotalFade.modulate.a < 1:
			$CanvasLayer/TotalFade.modulate.a += delta / 2
		else:
			$CanvasLayer/TotalFade.modulate.a = 1
	else:
		if $CanvasLayer/TotalFade.modulate.a > 0:
			$CanvasLayer/TotalFade.modulate.a -= delta
		else:
			$CanvasLayer/TotalFade.hide()
	if GameOverlayFadeIn:
		$CanvasLayer/GameOverlay.visible = true
		$CanvasLayer/PassedOrFailedText.visible = true
		if $CanvasLayer/GameOverlay.modulate.a < 0.5:
			$CanvasLayer/GameOverlay.modulate.a += delta
		if $CanvasLayer/PassedOrFailedText.rect_position.y < 100:
			$CanvasLayer/PassedOrFailedText.rect_position.y += 6
		if $CanvasLayer/PassedOrFailedText.modulate.a < 1:
			 $CanvasLayer/PassedOrFailedText.modulate.a += delta*2
	else:
		if $CanvasLayer/GameOverlay.modulate.a > 0:
			$CanvasLayer/GameOverlay.modulate.a -= delta
		else:
			$CanvasLayer/GameOverlay.visible = false
		if $CanvasLayer/PassedOrFailedText.modulate.a > 0:
			$CanvasLayer/PassedOrFailedText.modulate.a -= delta*2
		else:
			$CanvasLayer/PassedOrFailedText.visible = false
		if $CanvasLayer/PassedOrFailedText.rect_position.y > -250:
			$CanvasLayer/PassedOrFailedText.rect_position.y -= 8
	
	
	if !ChangingTimer:
		#Timer stuff
		TimeLabel.set_text(str(round(GameTimer.time_left)))
		TimeBar.set_value(GameTimer.time_left)
		
		if GameTimer.time_left > (NewTimerMax/2): #Go from green to yellow (0,1,0) to (1,1,0)
			TimeBar.tint_progress = Color((1-(GameTimer.time_left-(NewTimerMax/2))/(NewTimerMax/2)),1,0) #At the beginning this should be 10 which when subtracted 5 from and divided by 5 would be 1. Subtracting this from 1 would make the red value become stronger overtime until it is strongest, at five seconds
			TimeBar.tint_under = Color((1-(GameTimer.time_left-(NewTimerMax/2))/(NewTimerMax/2)),1,0)
		else: #Go from yellow to red
			TimeBar.tint_progress = Color(1,GameTimer.time_left/(NewTimerMax/2),0) #When this triggers the timer will only have at most 10 seconds so you can divide it by 5 and have at most 1 which as the timer decreases this makes the green value slowly dissapear
			TimeBar.tint_under = Color(1,GameTimer.time_left/(NewTimerMax/2),0)
	
	#This is how the game detects a game over
	if $CanvasLayer/TotalFade.modulate.a == 1 and HasFailedIsWaitingForFadeOut:
		#print("SwitchingScenes!")
		if get_tree().change_scene("res://Assets/Main/Title screen.tscn") != OK:
			print("An unexpected error occured when trying to switch to the title screen scene")
	
	
	if game == null or ChangingScenes:
		return # Makes all the checks below not happen because the game is not yet loaded or the player lost
	
	#Check if the player has failed or passed a scene yet
	if game.passed:
		ChangingScenes = true
		GameOverlayFadeIn = true
		ChangingTimer = true
		CompletedGames += 1
		$CanvasLayer/PassedOrFailedText.bbcode_text = "[center][color=green]Passed"
		$CanvasLayer/PassedOrFailedText/TotalGamesText.text = "Games Completed:  " + str(CompletedGames)
		GameTimer.stop()
		$CanvasLayer/TimeBetweenGames.start()
	if game.failed:
		if DidntQuitOut:
			ChangingScenes = true
			_fail()

func _on_Timer_timeout():
	ChangingScenes = true
	_fail()

func _on_QuitButton_pressed() -> void:
	_on_GameOverTimer_timeout()
	ChangingTimer = true
	DidntQuitOut = false

func _on_TimeBetweenGames_timeout(): #rest of the new scene script
	print("timer ran out, switching scenes")
	GameOverlayFadeIn = false
	
	if NewTimerMax > 5:
		NewTimerMax -= .25 # Sets the new low for the game timer
	GameTimer.wait_time = NewTimerMax
	#GameTimer.time = NewTimerMax
	GameTimer.start()
	TimeBar.set_value(NewTimerMax) #Resets value for each new minigame
	TimeBar.set_max(NewTimerMax) #Updates max value of bar so the bar displays properly
	ChangingTimer = false
	
	if game != null: # These are tests
		game.queue_free()
		#print("The game is ", game)
		game = null # Might not have to set this to null when it is also freed
		
	var rng = RandomNumberGenerator.new()
	rng.randomize()
	game = possible_scenes[rng.randi_range(0, len(possible_scenes) - 1)].instance()
	$CanvasLayer/GameHolder.add_child(game)
	
	ChangingScenes = false


func _on_GameOverTimer_timeout():
	TotalFadeIn = true
	HasFailedIsWaitingForFadeOut = true
