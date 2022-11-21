extends Node


var rng = RandomNumberGenerator.new()
var enemy_count = 2
var spawn_cooldown = 0.1

enum Enemy {
	REGULAR,
	DASHER,
	TANK,
}


func _ready():
	$WaveTimer.start()

func _on_WaveTimer_timeout():
	new_wave()
	$WaveTimer.wait_time += 2
	$WaveTimer.start()

func _spawn_enemy(enemy_type: int, location: Vector2):
	var enemy
	match (enemy_type): # we random!!
		Enemy.REGULAR: enemy = preload("res://enemy/regular/regular.tscn")
		Enemy.DASHER: enemy = preload("res://enemy/dasher/dasher.tscn")
		Enemy.TANK: enemy = preload("res://enemy/tank/tank.tscn")

	var e = enemy.instance()
	e.position = location
	add_child(e)

func new_wave():
	var unspawned = enemy_count # for counting how many enemies are already in
	
	for _i in range(enemy_count):
		for s in Global.player.get_spawns():
			if unspawned > 0:
				var type = rng.randi_range(0, 2)
				unspawned -= 1
				_spawn_enemy(type, s.position)
				yield(get_tree().create_timer(spawn_cooldown), "timeout")
			else:
				break
	
	enemy_count += 3


func _random_point(): # gets random point spawn_distance away
	var angle = deg2rad(rng.randf_range(0, 360))
	var point = Vector2(cos(angle), sin(angle)) # honors geometry
	return point * Global.spawn_dist # makes enemy spawn certain distance away
