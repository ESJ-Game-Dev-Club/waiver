extends Panel

export var slot_no:int = 0
var price = 0

func display(): #adds information to shop
	price = owner.shop_prices[slot_no]
	$Texture.texture = owner.items[slot_no].inventory_icon
	$ItemLabel.text = str(owner.items[slot_no])
	$ItemPrice.text = str(price) + " kills"



func _on_ItemBuy_pressed(): #handles purchacing from a shop
	if Global.player.kill_count < price:
		pass
	else:
		Global.player.kill_count = Global.player.kill_count - price
		Global.player.pickup_item(owner.items[slot_no].item_type, owner.items[slot_no].inventory_icon, owner.items[slot_no].item_scene_path)
		$ItemBuy.disabled = true
		$ItemBuy.text = "Sold Out"
