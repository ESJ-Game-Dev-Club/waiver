extends CanvasItem

const SEPARATION_WEIGHT = 0.5
const ALIGNMENT_WEIGHT = 0.5
const COHESION_WEIGHT = 0.1

var agent = preload("res://enemy/agent.tscn")

func spawn_agent(position: Vector2) -> void:
	var agent_instance = agent.instance()
	agent_instance.position = position
	add_child(agent_instance)

#func _agent_process(agent)

func _physics_process(_delta):
	for agent in get_children():
		var direction = (Global.player.position - agent.position).normalized()
		var goal = direction * agent.max_speed
		var to_goal = goal - agent.velocity
		var accel_speed = min(agent.max_accel, to_goal.length())
		agent.velocity += to_goal.normalized() * accel_speed
		agent.position += agent.velocity
	
	if Input.is_action_pressed("fire_alt"):
		spawn_agent(Vector2.ZERO)
		spawn_agent(Vector2.ZERO)
		spawn_agent(Vector2.ZERO)
		spawn_agent(Vector2.ZERO)
		spawn_agent(Vector2.ZERO)
		spawn_agent(Vector2.ZERO)
		spawn_agent(Vector2.ZERO)
		spawn_agent(Vector2.ZERO)
		spawn_agent(Vector2.ZERO)
		spawn_agent(Vector2.ZERO)

#export(StreamTexture) var texture
#export(int, LAYERS_2D_PHYSICS) var layer := 8
#export(int, LAYERS_2D_PHYSICS) var mask := 1
#
#var agents: Array = []
#
#func _ready():
#	spawn_agent(Vector2.ZERO)
#
#func _physics_process(_delta):
#	# individual agent logic is handled under here
#	for agent in agents:
#		agent = agent as agent
#		print(agent.transform)
#		agent.velocity = Vector2(1, 1)
#		agent.transform.origin += agent.velocity
#		Physics2DServer.area_set_transform(agent.area_rid, agent.transform)
#		VisualServer.canvas_item_set_transform(agent.ci_rid, agent.transform)
#
##func _physics_process(_delta):
##	agents[0].velocity.x = 1
##	agents[0].position += agents[0].velocity
##	Physics2DServer.body_set_state(agents[0].body_rid, Physics2DServer.BODY_STATE_TRANSFORM, Transform2D(0, agents[0].position))
##	VisualServer.canvas_item_set_transform(agents[0].ci_rid, Transform2D(0, agents[0].position))
#
## create the agent and append the agent object to the agents array
#func spawn_agent(position: Vector2) -> void:
#	var agent := agent.new()
#	agent.transform.origin = position
#
#	# create the texture
#	var ci_rid = VisualServer.canvas_item_create()
#	agent.ci_rid = ci_rid
#	VisualServer.canvas_item_set_parent(ci_rid, get_canvas_item())
#	var tex = texture
#	var rect = Rect2(Vector2(-tex.get_size().x / 2, -tex.get_size().y / 2), tex.get_size())
#	VisualServer.canvas_item_add_texture_rect(ci_rid, rect, tex)
#	# create shape
#	var shape_rid = Physics2DServer.circle_shape_create()
#	agent.shape_rid = shape_rid
#	Physics2DServer.shape_set_data(shape_rid, 16)
#	# create area
#	var area_rid = Physics2DServer.area_create()
#	agent.area_rid = area_rid
#	Physics2DServer.area_add_shape(area_rid, shape_rid)
#	Physics2DServer.area_set_space(area_rid, get_world_2d().space)
#	Physics2DServer.area_set_collision_layer(area_rid, layer)
#	Physics2DServer.area_set_collision_mask(area_rid, mask)
#	Physics2DServer.area_set_monitor_callback(area_rid, self, "_area_callback")
#
#	agents.append(agent)
