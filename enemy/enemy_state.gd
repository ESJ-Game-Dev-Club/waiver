class_name EnemyState
extends State


var enemy: Enemy
var movement_script

func _ready():
	movement_script = get_child(0) # we assume that the enemy state node has only 1 child
	enemy = owner

func enter():
	enemy = owner


func physics_process(delta):
	movement_script.run(delta)


func hit(dmg):
	enemy.health -= dmg
	enemy.modulate = Color(8, 8, 8, 1)
	
	if (enemy.health <= 0): # enemy is dead
		Global.player.kill_count += 1
		enemy.queue_free()
	else:
		var _t = flash_timer() # only call flash timer method if enemy exists
		enemy.velocity += -_player_direction() * enemy.knockback # knockback

func flash_timer():
	yield(get_tree().create_timer(0.1), "timeout")
	enemy.modulate = Color(1, 1, 1, 1)


# this method is always useful
func _player_direction() -> Vector2: 
	return (Global.player.position - owner.position).normalized()
