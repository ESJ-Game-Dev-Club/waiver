extends KinematicBody2D


class_name Ememy

enum EnemyState {
	WANDER,
	CHASING,
}

var rng = RandomNumberGenerator.new()

export var speed: int = 75
export var health = 3
var stagger: int
var current_state = EnemyState.WANDER


func _ready():
	rng.randomize()
	$Timer.start()


func _physics_process(delta):
	if (health == 0): # enemy is dead
		queue_free()

	var player_distance = self.position.distance_to(GlobalVars.player.position)
	if (player_distance < 300):
		current_state = EnemyState.CHASING
		
	match(current_state):
		EnemyState.WANDER: self.wander()
		EnemyState.CHASING: self.chase()


func _input(event):
	if (event.is_action_pressed("enemy_hurt")):
		health-=1


func wander():
	move_and_slide(_player_direction().rotated(stagger) * (speed * 0.4))


func chase():
	move_and_slide(_player_direction() * speed)


func _on_Timer_timeout():
	stagger = deg2rad(rng.randf_range(0, 180))


func _player_direction() -> Vector2:
	# gets direction to player
	return (GlobalVars.player.position - position).normalized()
