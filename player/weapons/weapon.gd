class_name Weapon
extends Node2D

var atk_time = 0.2

# this function is called from the player (because FSM control)
func fire() -> bool:
	return false # return true if we could fire
