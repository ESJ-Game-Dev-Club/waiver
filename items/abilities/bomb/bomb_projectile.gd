extends Node2D

var damage = 1

var speed = 150
var direction:Vector2 = Vector2.ZERO

func _physics_process(delta):
	var velocity = direction * speed * delta

	global_position += velocity

func set_direction(dir):
	direction = dir

func explode():
	for body in $Explosion.get_overlapping_bodies(): # kill
		body.hit(damage * Global.player.get_modifier("damage"))

	queue_free()


func _on_Timer_timeout():
	explode()

func _on_Projectile_body_entered(body):
	explode()
