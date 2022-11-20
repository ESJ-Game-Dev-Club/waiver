extends EnemyState


export var chase_distance: int = 300


func physics_process(delta):
	if enemy.position.distance_to(Global.player.position) < chase_distance:
		enemy.transition_to(enemy.get_node("States/Chasing"))
	
	movement_script.run(delta)
