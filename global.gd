extends Node


signal player_state_changed(state_name)
signal item_change(slot, texture)

onready var player: Player = get_node("/root/Main/Player")

var spawn_dist = 512 # enemies will spawn this far away from player
