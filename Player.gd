extends KinematicBody2D

export (int) var speed = 200
export (float) var rotation_speed = 1.5

onready var target = position # mesmo que func _ready() ...

var velocity = Vector2.ZERO
var rotation_dir = 0

#func _ready() -> void:
#	target = position
	
func get_8way_input():
#	velocity = Vector2.ZERO
	velocity.x = Input.get_action_strength("right") - Input.get_action_strength("left")
	velocity.y = Input.get_action_strength("down") - Input.get_action_strength("up")
	velocity = velocity.normalized() * speed
	#print(velocity)
	
func get_rotation_input():
	rotation_dir = 0
	velocity = Vector2.ZERO
	rotation_dir = Input.get_action_strength("right")-Input.get_action_strength("left")
	if Input.is_action_pressed("down"):
		velocity = Vector2(0,speed).rotated(rotation)
	if Input.is_action_pressed("up"):
		velocity = Vector2(0, -speed).rotated(rotation)
		
func get_mouse_input():
	look_at(get_global_mouse_position())
	rotation_degrees += 90
	velocity = Vector2()
	if Input.is_action_pressed("down"):
		velocity = Vector2(0, speed).rotated(rotation)
	if Input.is_action_pressed("up"):
		velocity = Vector2(0, -speed).rotated(rotation)

func get_mouse_velocity():
	velocity = position.direction_to(target) * speed
	print(velocity)
	
func _input(event): # mouse click to move
	if event.is_action_pressed("click"):
		target = get_global_mouse_position()
		print(target)
		
func _physics_process(delta):
	#get_8way_input()
	#get_rotation_input()
	#get_mouse_input()
	get_mouse_velocity()
	look_at(target)
	#rotation += rotation_dir * rotation_speed * delta # usar com get_rotation_input
	if position.distance_to(target) > 5:
		velocity = move_and_slide(velocity)

