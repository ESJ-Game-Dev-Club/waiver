extends Weapon

var base_cooldown = 0.9

var ready = true # for cooldown timer
export(Color) var normal_color
export(Color) var attack_color
export(Color) var cooldown_color

# func _ready():
# 	Global.connect("item_change", self, "update_cooldown")

func _process(_delta):
	look_at(get_global_mouse_position())
	$CooldownTimer.wait_time = 0.9 * Global.player.get_modifier("cooldown")
 

func fire() -> bool:
	if !ready:
		return false

	$Polygon2D.color = attack_color
	for body in $Area2D.get_overlapping_bodies(): # kill
		body.hit(1 * Global.player.get_modifier("damage"))

	$ColorTimer.start()
	ready = false
	return true

# func update_cooldown():
# 	$CooldownTimer.wait_time = 0.9 * Global.player.get_modifier("cooldown")
# 	print("test")

func _on_ColorTimer_timeout(): # when done attacking, cool down
	$Polygon2D.color = cooldown_color
	$CooldownTimer.start()

func _on_CooldownTimer_timeout(): # when done cooling down, get ready to attack
	$Polygon2D.color = normal_color
	ready = true
