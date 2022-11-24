class_name Agent
extends Area2D

var velocity := Vector2.ZERO
var max_speed := 100
var max_accel := 20

#func _physics_process(delta):
#	var direction = (Global.player.position - position).normalized()
#	var goal = direction * max_speed
#	var to_goal = goal - velocity
#	var accel_speed = min(max_accel, to_goal.length())
#	velocity += to_goal.normalized() * accel_speed
#	position += velocity
