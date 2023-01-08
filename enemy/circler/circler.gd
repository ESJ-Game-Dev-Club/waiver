extends Agent

var circle_distance = 200
var allowed_error = 50
var maintain_weight = 0.2

# find the change in velocity
func _steering():
	# steering += _behavior() * weighting + ...
	var steering := Vector2.ZERO
	# filters out which neighbors are closest
	var nearby: Array = get_closest(Global.hivemind.agents, view_distance)
	
	# find point on circle that is closest to agent
	var circle_point = (position - Global.player.position).normalized() * circle_distance + Global.player.position
	
	var distance = position.distance_to(Global.player.position) # distance to player
	# if agent is within the circling area
	if distance >= circle_distance - allowed_error and distance <= circle_distance + allowed_error:
		# circle the player
		var tangent_vector = (Global.player.position - position).rotated(deg2rad(90)).normalized()
		steering += tangent_vector * acceleration
	
		# maintain distance
		steering += (circle_point - position).normalized() * acceleration * maintain_weight
	else:
		# go toward player
		steering += (circle_point - position).normalized() * acceleration
	
	steering += _separation(nearby, 32) * 0.5
	
	
	
	return steering.clamped(acceleration)
