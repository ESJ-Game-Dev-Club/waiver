extends Enemy


class_name Dasher


func wander():
	move_and_slide(_player_direction() * speed)


func chase():
	move_and_slide(_player_direction() * speed)
