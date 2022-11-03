extends PlayerState

var atk_cooldown_mult = 0.1

# Called when the node enters the scene tree for the first time.
func _ready():
	player.atk_cooldown_mult = atk_cooldown_mult

func _exit_tree():
	player.atk_cooldown_mult = 1
