class_name Pickup
extends Area2D

enum ItemType {
	WEAPON,
	SPECIAL,
	TRINKET,
}

export(Texture) var inventory_icon
export(String) var item_scene_path
export(ItemType) var item_type
