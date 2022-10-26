extends Node

export var slot_number :int = 0 #set array value
func _ready():
	GlobalVars.connect("item_change", self, "initialize_item")
	print("hi")

func initialize_item(slot, texture):
	if slot_number ==  slot:
		$TextureRect.texture = load(texture)
