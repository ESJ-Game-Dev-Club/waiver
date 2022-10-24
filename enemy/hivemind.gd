extends Node


var rng = RandomNumberGenerator.new()
var enemy = preload("res://enemy/enemy.tscn")


func _ready():
	$Timer.start()

func _on_Timer_timeout():
	_instance_enemy()
	$Timer.start()

func _instance_enemy():
	var i = enemy.instance()
	i.position = _random_point() + GlobalVars.player.position # add player offset
	add_child(i)

func _random_point(): # gets random point spawn_distance away
	rng.randomize()
	var angle = deg2rad(rng.randf_range(0, 360))
	var point = Vector2(cos(angle), sin(angle)) # honors geometry
	return point * GlobalVars.spawn_dist # makes enemy spawn certain distance away
