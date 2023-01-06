class_name Agent
extends Area2D

var velocity := Vector2.ZERO
var acceleration := 30
var max_speed := 100
var view_distance = 200
var separation_distance = 70
var separation_weight = 0.4


func _ready():
	velocity = Vector2(0, 30).rotated(rand_range(0, 360))

func _physics_process(delta):
	var steering = Vector2.ZERO
	var neighbors = get_neighbors(view_distance)
	
	var separation := Vector2.ZERO
	for neighbor in neighbors:
		if position.distance_to(neighbor.position) <= separation_distance:
			separation += (position - neighbor.position).normalized()
	steering += separation * separation_weight
	
	velocity = steering.clamped(acceleration)
	position += velocity.clamped(max_speed) * delta


func get_neighbors(distance):
	var neighbors: Array = []
	for agent in Global.hivemind.agents:
		if position.distance_to(agent.position) <= distance and position != agent.position:
			neighbors.append(agent)
	return neighbors
