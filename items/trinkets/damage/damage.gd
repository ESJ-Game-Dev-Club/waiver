extends PlayerState

var atk_dmg_mult = 3

# Called when the node enters the scene tree for the first time.
func _ready():
	player.atk_dmg_mult = atk_dmg_mult

func _exit_tree():
	player.atk_dmg_mult = 1
