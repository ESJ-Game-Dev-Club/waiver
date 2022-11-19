extends CanvasLayer


func _process(_delta):
	$Control/Health.text = "Health: " + str(Global.player.health)
	$Control/Health.text = "Health: " + str(Global.player.health)
	$Control/State.text = Global.player._state_name
	$Control/KillCount.text = "Kills:" + str(Global.player.kill_count)
