extends Node


var rng = RandomNumberGenerator.new()
var enemy = preload("res://enemy/enemy.tscn")

var enemy_count = 0

func _ready():
	rng.randomize()
	new_wave()
	$Timer.start()


func _on_Timer_timeout():
	new_wave()
	$Timer.wait_time += 2
	$Timer.start()


func _spawn_enemy():
	var e = enemy.instance()
	e.position = _random_point() + Global.player.position # add player offset
	add_child(e)


func new_wave():
	enemy_count += 5
	
	for i in range(enemy_count):
		_spawn_enemy()


func _random_point(): # gets random point spawn_distance away
	rng.randomize()
	var angle = deg2rad(rng.randf_range(0, 360))
	var point = Vector2(cos(angle), sin(angle)) # honors geometry
	return point * Global.spawn_dist # makes enemy spawn certain distance away
