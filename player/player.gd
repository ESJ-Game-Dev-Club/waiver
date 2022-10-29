class_name Player
extends StateMachine


var normal_speed = 100
var staggered_speed = 110 # makes it easy for player to escape

var health = 3

var inventory_array: Array = [null, null, null] # weapon, special, trinket


func _unhandled_input(event):
	_state.unhandled_input(event)

func _input(event): # remove all items
	if event.is_action_pressed("ui_accept"):
		for n in range(0, 3):
			trash_item(n)
			Global.emit_signal("item_change", n, null)

func trash_item(item_type):
	if inventory_array[item_type] == null:
		return
	
	if (item_type == Pickup.ItemType.TRINKET and
			_state == inventory_array[item_type]):
		transition_to($States/Normal)
	inventory_array[item_type].queue_free()
	inventory_array[item_type] = null

func pickup_item(item_type, icon, scene_path):
	trash_item(item_type) # remove player's previous item
	var scene = load(scene_path)
	var i = scene.instance()
	inventory_array[item_type] = i
	$Items.call_deferred("add_child", i)
	if item_type == Pickup.ItemType.TRINKET:
		transition_to(i)
	Global.emit_signal("item_change", item_type, icon)

func _on_pickup(area):
	if _state.has_method("on_pickup"):
		_state.on_pickup(area)
