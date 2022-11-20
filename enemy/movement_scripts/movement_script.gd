class_name MovementScript
extends Node


onready var enemy: Enemy = owner


func run(_delta):
	return Vector2.ZERO

func _get_move(velocity: Vector2, direction: Vector2, acceleration: int, max_speed: int):
	var goal = direction * max_speed # the desired direction
	var to_goal = goal - velocity # direction from velocity to desired direction
	var accel_speed = min(acceleration, to_goal.length()) # clamp the speed
	return to_goal.normalized() * accel_speed # return the movement

# this method is always useful
func _player_direction() -> Vector2:
	return (Global.player.position - owner.position).normalized()
