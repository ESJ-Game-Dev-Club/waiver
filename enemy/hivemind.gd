extends CanvasItem

const SEPARATION_WEIGHT = 0.5
const ALIGNMENT_WEIGHT = 0.5
const COHESION_WEIGHT = 0.1

var agent = preload("res://enemy/agent.tscn")
var agents := []

func spawn_agent(position: Vector2) -> void:
	var agent_instance = agent.instance()
	add_child(agent_instance)

func _physics_process(_delta):
	if Input.is_action_just_pressed("fire_alt"):
		spawn_agent(Vector2.ZERO)
