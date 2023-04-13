extends Node2D

const SPEED : = 300
var total : float = 0

func _ready() -> void:
	update_score(total)

func _input(event: InputEvent) -> void:
	#if event.is_action_pressed("right"):
	#	position.x += 5
	print("Right!")
		
func _physics_process(delta: float) -> void:
	total += delta
	#print(delta)
	update_score(total)
	if Input.is_action_pressed("right"):
		position.x += SPEED * delta
	if Input.is_action_pressed("left"):
		position.x -= SPEED * delta
	if Input.is_action_pressed("down"):
		position.y += SPEED * delta
	if Input.is_action_pressed("up"):
		position.y -= SPEED * delta
	
func update_score(current_score: float) -> void:
	$Score.text = str(total)
			
