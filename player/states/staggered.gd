extends PlayerState


func unhandled_input(_event): # prevent the player from attacking when staggered
	pass

func physics_process(_delta):
	player.velocity += _get_move(_get_input(), player.staggered_accel * player.get_modifier("speed"), player.staggered_speed * player.get_modifier("speed"))
	player.velocity = player.move_and_slide(player.velocity)

func enter():
	$StaggerTimer.start()
	$FlashTimer.start()

func exit():
	$FlashTimer.stop()
	$StaggerTimer.stop()
	player.show()

# either switch to trinket state if available or normal state
func _on_StaggerTimer_timeout():
	if player.inventory_array[Pickup.ItemType.TRINKET] != null:
		player.transition_to(player.inventory_array[Pickup.ItemType.TRINKET])
	else:
		player.transition_to(get_node("../Normal"))

func _on_FlashTimer_timeout():
	player.visible = not player.visible
