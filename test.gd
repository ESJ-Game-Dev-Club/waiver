extends RigidBody2D


func _integrate_forces(state):
	state.linear_velocity = Vector2(20, 20)
