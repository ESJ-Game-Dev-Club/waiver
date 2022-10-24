extends KinematicBody2D


func _physics_process(delta):
	move_and_collide(_get_input() * 1.8)


func _get_input() -> Vector2:
	return (GlobalVars.player.position - position).normalized()
