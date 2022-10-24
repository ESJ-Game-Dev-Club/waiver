extends CanvasLayer


func _process(delta):
	$Control/Health.text = "Health: " + str(GlobalVars.player.health)
	$Control/State.text = GlobalVars.player.States.keys()[GlobalVars.player.current_state]
