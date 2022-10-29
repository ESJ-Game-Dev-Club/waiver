extends PlayerState


func physics_process(_delta):
	# if player is touching enemy
	if player.get_node("HitDetection").get_overlapping_bodies().size() > 0:
		player.health -= 1
		
		if player.health == 0:
			player.queue_free() # crash the game on loss
		
		player.transition_to(get_node("../Staggered"))
		return
	
	player.move_and_slide(_get_input() * player.normal_speed)
