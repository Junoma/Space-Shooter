extends CharacterBody2D

func _init():
	pass

func _process(delta):
	pass

var speed = 8
var max_speed = 700
var rotate_speed = 0.08


func _physics_process(delta):
	if Input.is_action_pressed("Left"):
		rotation -= rotate_speed
	if Input.is_action_pressed("Right"):
		rotation += rotate_speed
	if Input.is_action_pressed("Forwards"):
		velocity = velocity + Vector2(0,-speed).rotated(rotation)
	print(velocity)
	
	position.x = wrapf(position.x, 0, 1152)
	position.y = wrapf(position.y, 0, 648)
	velocity = velocity.normalized() * clamp(velocity.length(), 0, max_speed)
	
	print(velocity.length())
	
	move_and_slide()
	

