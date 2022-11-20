extends Node


var rng = RandomNumberGenerator.new()
var enemy_count = 0

enum Enemy {
	REG,
	DASHER,
	TANK,
}


func _ready():
	rng.randomize()
	new_wave()
	$Timer.start()


func _on_Timer_timeout():
	new_wave()
	$Timer.wait_time += 2
	$Timer.start()


func _spawn_enemy(enemy_type: int):
	var enemy = preload("res://enemy/enemy.tscn")
	
	match (enemy_type):
		Enemy.REG: enemy = preload("res://enemy/enemy.tscn")
		Enemy.DASHER: enemy = preload("res://enemy/dasher/enemy.tscn")
		Enemy.TANK: enemy = preload("res://enemy/tank/enemy.tscn")

	var e = enemy.instance()
	e.position = _random_point() + Global.player.position # add player offset
	add_child(e)


func new_wave():
	enemy_count += 5
	
	for i in range(enemy_count):
		var type = rng.randi_range(0, 2)
		_spawn_enemy(type)


func _random_point(): # gets random point spawn_distance away
	rng.randomize()
	var angle = deg2rad(rng.randf_range(0, 360))
	var point = Vector2(cos(angle), sin(angle)) # honors geometry
	return point * Global.spawn_dist # makes enemy spawn certain distance away
