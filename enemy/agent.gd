class_name Agent
extends KinematicBody2D


var current_update := 1
var update_mod := 5

var velocity := Vector2.ZERO
var acceleration := 30
var max_speed := 90
var view_distance = 200 # max view distance that the agent can see other agents


func _ready():
	velocity = Vector2(0, 30).rotated(rand_range(0, 360))

# find the change in velocity
func _steering():
	# steering += _behavior() * weighting + ...
	var steering := Vector2.ZERO
	# filters out which neighbors are closest
	var nearby: Array = get_closest(Global.hivemind.agents, view_distance)
	
	# boid model
	steering += _cohesion(nearby, 200) * 0.003 + _alignment(nearby, 200) * 0.01 + _separation(nearby, 32) * 0.005
	
	# go towards player
	if Input.is_action_pressed("fire"):
		$NavigationAgent2D.set_target_location(Global.player.position)
		steering += _seek($NavigationAgent2D.get_next_location()) * 0.1
	
	return steering.clamped(acceleration)

func _physics_process(delta):
	if current_update % update_mod == 0:
		# apply steering and clamp the velocity
		velocity += _steering()
		velocity = velocity.clamped(max_speed)
		current_update = 1
	else:
		current_update += 1
	
	# move the agent
	velocity = move_and_slide(velocity)

func _seek(target: Vector2):
	var desired_velocity = (target - position).normalized() * max_speed
	return desired_velocity - velocity

# calculate the average position and apply weighting
func _cohesion(nearby: Array, distance):
	var neighbors = get_closest(nearby, distance) # gets neighbors within certain range
	if neighbors.size() == 0:
		return Vector2.ZERO
	
	# average all neighboring agent's positions
	var average_position = Vector2.ZERO
	for neighbor in neighbors:
		average_position += neighbor.position
	average_position.x /= neighbors.size()
	average_position.y /= neighbors.size()
	
	# direction to center
	return average_position - position

# calculate the average velocity and apply weighting
func _alignment(nearby: Array, distance):
	var neighbors = get_closest(nearby, distance)
	if neighbors.size() == 0:
		return Vector2.ZERO
	
	# average up all neighboring agent's velocities
	var average_velocity = Vector2.ZERO
	for neighbor in neighbors:
		average_velocity += neighbor.velocity
	average_velocity.x /= neighbors.size()
	average_velocity.y /= neighbors.size()
	
	# direction to average direction
	return average_velocity - velocity

# steer away from nearby agents
func _separation(nearby: Array, distance):
	var neighbors = get_closest(nearby, distance)
	if neighbors.size() == 0:
		return Vector2.ZERO
	
	var closeness = Vector2.ZERO
	for neighbor in neighbors:
		var magnitude = distance - position.distance_to(neighbor.position)
		closeness += (position - neighbor.position) * magnitude
	
	return closeness


func get_closest(nodes, distance):
	var neighbors: Array = []
	for node in nodes:
		if position.distance_to(node.position) <= distance and position != node.position:
			neighbors.append(node)
	return neighbors
