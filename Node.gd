extends Node2D

var beginPlayLineMade = false
var spawnActorLineMade = false
var setRunLineMade = false
var beginPlaySet = false
var spawnActorSet = false
var setRunSet = false

var rng


func _ready():
	rng = RandomNumberGenerator.new()
	rng.randomize()
	var beginPlayPos = rng.randf_range(-30,30)
	var spawnActorPos = rng.randf_range(-30,30)
	var setRunPos = rng.randf_range(-30,30)
	
	$BeginPlay.global_position = $BeginPlay.global_position + Vector2(beginPlayPos,beginPlayPos)
	$SpawnActor.global_position = $SpawnActor.global_position + Vector2(spawnActorPos,spawnActorPos)
	$SetRun.global_position = $SetRun.global_position + Vector2(setRunPos,setRunPos)
	
func _process(delta):
	
	
	if beginPlayLineMade:
		$BeginPlay/StartBeginPlay/LineBeginPlay.set_point_position(1,get_global_mouse_position() - $BeginPlay/StartBeginPlay/LineBeginPlay.global_position)
	if spawnActorLineMade:
		$SpawnActor/StartSpawnActor/LineSpawnActor.set_point_position(1,get_global_mouse_position() - $SpawnActor/StartSpawnActor/LineSpawnActor.global_position)
	if setRunLineMade:
		$SetRun/StartSetRun/LineSetRun.set_point_position(1,get_global_mouse_position() - $SetRun/StartSetRun/LineSetRun.global_position)
		
	if Input.is_action_just_released("LMC"):
		beginPlayLineMade = false
		spawnActorLineMade = false
		setRunLineMade = false
		
		if beginPlaySet == false:
			$BeginPlay/StartBeginPlay/LineBeginPlay.set_point_position(1,Vector2(0,0))
		if spawnActorSet == false:
			$SpawnActor/StartSpawnActor/LineSpawnActor.set_point_position(1,Vector2(0,0))
		if setRunSet == false:
			$SetRun/StartSetRun/LineSetRun.set_point_position(1,Vector2(0,0))

# Begin Play
func _on_StartBeginPlay_input_event(viewport, event, shape_idx):
	if Input.is_action_just_pressed("LMC"):
		beginPlayLineMade = true
		beginPlaySet = false

# Spawn Actor
func _on_StartSpawnActor_input_event(viewport, event, shape_idx):
	if Input.is_action_just_pressed("LMC"):
		spawnActorLineMade = true
		spawnActorSet = false

# Set Run
func _on_StartSetRun_input_event(viewport, event, shape_idx):
	if Input.is_action_just_pressed("LMC"):
		setRunLineMade = true
		setRunSet = false

# Spawn Actor
func _on_EndSpawnActor_input_event(viewport, event, shape_idx):
	if beginPlayLineMade:
		if Input.is_action_just_released("LMC"):
			beginPlaySet = true

# Set Run
func _on_EndSetRun_input_event(viewport, event, shape_idx):
	if spawnActorLineMade:
		if Input.is_action_just_released("LMC"):
			spawnActorSet = true


func _on_Button_pressed():
	if beginPlaySet and spawnActorSet:
		print("YIPPEE")
	else:
		print("YOU SUCK")
