extends MovementScript


export(int) var acceleration: int = 30
export(int) var max_speed: int = 75


func run(_delta):
	enemy.velocity += _get_move(enemy.velocity, _player_direction(), acceleration, max_speed)
	enemy.velocity = enemy.move_and_slide(enemy.velocity)
