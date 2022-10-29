extends "res://enemy/enemy.gd"


class_name Tank


func wander():
	move_and_slide(_player_direction().rotated(stagger) * (speed * 0.4))


func chase():
	move_and_slide(_player_direction() * speed)
