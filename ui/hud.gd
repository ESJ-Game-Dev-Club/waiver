extends CanvasLayer


func _process(delta):
	if (GlobalVars.player.health):
		$Control/Health.text = "Health: " + str(GlobalVars.player.health)
	else:
		$Control/Health.text = "Health: 0"
		
	$Control/State.text = GlobalVars.player.States.keys()[GlobalVars.player.current_state]
