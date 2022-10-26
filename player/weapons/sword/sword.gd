extends Weapon 

var ready = true # for cooldown timer
export(Color) var normal_color
export(Color) var attack_color
export(Color) var cooldown_color


func _ready():
	atk_time = 0.1

func fire() -> bool:
	if ready:
		$Polygon2D.color = attack_color
		for body in $Area2D.get_overlapping_bodies(): # kill
			body.queue_free()
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
