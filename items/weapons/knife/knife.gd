extends Weapon

var base_cooldown = 0.9

var ready = true # for cooldown timer
export(Color) var normal_color
export(Color) var attack_color
export(Color) var cooldown_color


func _process(delta):
	look_at(get_global_mouse_position())
	$CooldownTimer.wait_time = 0.9 * Global.player.atk_cooldown_mult

func fire() -> bool:
	if ready:
		$Polygon2D.color = attack_color
		for body in $Area2D.get_overlapping_bodies(): # kill
			body.hit(1 * Global.player.atk_dmg_mult)
		ready = false
		$ColorTimer.start()
		return true
	return false

func _on_ColorTimer_timeout(): # when done attacking, cool down
	$Polygon2D.color = cooldown_color
	$CooldownTimer.start()

func _on_CooldownTimer_timeout(): # when done cooling down, get ready to attack
	$Polygon2D.color = normal_color
	ready = true
