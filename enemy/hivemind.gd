extends Node

var agent = preload("res://enemy/agent.tscn")
var agents := []

func spawn_agent(position: Vector2) -> void:
	var agent_instance = agent.instance()
	agent_instance.position = position
	agents.append(agent_instance)
	add_child(agent_instance)

func _physics_process(_delta):
	if Input.is_action_pressed("fire_alt"):
		var position = Vector2.ZERO
		position.x = rand_range(-200, 200)
		position.y = rand_range(-200, 200)
		spawn_agent(position + Global.player.position)
