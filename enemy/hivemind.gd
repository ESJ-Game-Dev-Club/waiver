extends Node2D

# how far a spawn can be before it is no longer in range
onready var spawn_range = Global.player.get_node("SpawnRange/CollisionShape2D").shape.radius

var agent = preload("res://enemy/circler/circler.tscn")
var agents := []

func _input(event):
	if event.is_action_pressed("fire_alt"):
#		spawn_agent(_get_viable_spawns()[0].position)
		for spawn in _get_viable_spawns():
			spawn_agent(spawn.position)

func spawn_agent(position: Vector2) -> void:
	var agent_instance = agent.instance()
	agent_instance.position = position
	agents.append(agent_instance)
	add_child(agent_instance)

func _get_viable_spawns():
	return Global.player.get_node("SpawnRange").get_overlapping_areas()
