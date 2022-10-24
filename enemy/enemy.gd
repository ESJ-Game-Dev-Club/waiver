extends KinematicBody2D


var speed = 75


func _physics_process(delta):
	move_and_slide(_player_direction() * speed)

func _player_direction() -> Vector2:
	# gets direction to player
	return (GlobalVars.player.position - position).normalized()
