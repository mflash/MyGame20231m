extends KinematicBody2D

export (int) var speed = 200
export (float) var rotation_speed = 1.5
export (int) var jump_speed = 1000
export (int) var gravity = 3000
export (PackedScene) var box : PackedScene

onready var target = position # mesmo que func _ready() ...
onready var sprite = $Sprite
#onready var box := preload("res://Items/Box.tscn")


var velocity = Vector2.ZERO
var rotation_dir = 0

#func _ready() -> void:
#	target = position
	
func get_8way_input():
#	velocity = Vector2.ZERO
	velocity.x = Input.get_action_strength("right") - Input.get_action_strength("left")
	velocity.y = Input.get_action_strength("down") - Input.get_action_strength("up")
	if velocity.x > 0:
		sprite.play("right")
	elif velocity.x < 0:
		sprite.play("left")
	elif velocity.y > 0:
		sprite.play("down")
	elif velocity.y < 0:
		sprite.play("up")
	else:
		sprite.stop()
		sprite.frame = 0
		
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
		
func get_side_input():
	velocity.x = Input.get_action_strength("right") - Input.get_action_strength("left")	
	velocity.x *=  speed
	if velocity.x > 0:
		sprite.play("right")
	elif velocity.x < 0:
		sprite.play("left")
	else:
		sprite.stop()
		sprite.frame = 0

	
	if Input.is_action_pressed("jump") and is_on_floor():
		velocity.y = -jump_speed
		get_tree().call_group("HUD", "updateScore")
		var b = box.instance()
		b.position = global_position
		owner.add_child(b)
	#print(velocity)
		
func _physics_process(delta):
	#get_8way_input() # 1.
	#get_rotation_input() # 2.
	#get_mouse_input() # 3.
	#get_mouse_velocity() # 4.
	#look_at(target) # 4.
	#rotation += rotation_dir * rotation_speed * delta # usar com 2.
	#if position.distance_to(target) > 5: # usar com o 4.	
	get_side_input()	
	velocity.y += gravity * delta
	#print(velocity)
	velocity = move_and_slide(velocity, Vector2.UP)
	#move_and_collide(velocity * delta)
