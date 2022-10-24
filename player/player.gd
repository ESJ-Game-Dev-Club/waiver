extends KinematicBody2D


func _ready():
	GlobalVars.player = self


func _physics_process(delta):
	move_and_collide(_get_input() * 2)


func _get_input() -> Vector2:
	var input = Vector2.ZERO
	
	if Input.is_action_pressed("move_up"):
		input.y -= 1
	if Input.is_action_pressed("move_down"):
		input.y += 1
	if Input.is_action_pressed("move_left"):
		input.x -= 1
	if Input.is_action_pressed("move_right"):
		input.x += 1
	
	return input.normalized()
