extends Node

export(Pickup.ItemType) var item_type


func _ready():
	Global.connect("item_change", self, "initialize_item")

func initialize_item(type, icon):
	if type ==  item_type:
		$TextureRect.texture = icon
