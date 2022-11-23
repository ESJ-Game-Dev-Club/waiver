extends Weapon

var base_cooldown = 0.9
var ready = true # for cooldown timer
var projectile_direction = Vector2.ZERO

var projectile = preload("res://items/abilities/bomb/bomb_projectile.tscn")

func fire() -> bool:
	projectile_direction = (get_global_mouse_position() - Global.player.position).normalized()
	$CooldownTimer.wait_time = base_cooldown * Global.player.get_modifier("cooldown")

	if !ready:
		return false
	
	var p = projectile.instance()
	p.set_direction(projectile_direction)
	p.position = Global.player.position
	get_node("/root/Main/Projectiles").add_child(p)

	$CooldownTimer.start()
	ready = false
	return true

func _on_CooldownTimer_timeout():
	ready = true
