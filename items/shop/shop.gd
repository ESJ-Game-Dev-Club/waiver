extends Area2D

export var shop_items:Array = ["", "", ""] # exports filepath
var items:Array = [null, null, null] # stores packaged scenes
export var shop_prices:Array = [null, null, null] # stores prices

func _on_Shop_body_entered(body:Node):
	if body.name == "Player":
		get_tree().paused = true
		$CanvasLayer.visible = true
		$CanvasLayer/Anim.play("shop_trans_in")

func _on_CloseButton_pressed():
	get_tree().paused = false
	$CanvasLayer/Anim.play("shop_trans_out")
	
func _on_Anim_animation_finished(anim_name:String):
	if anim_name == "shop_trans_out":
		$CanvasLayer.visible = false

func _ready():
	for i in range(0, 3): # converts scene paths to packed scenes
		items[i] = load(shop_items[i]).instance()

	for slot in $CanvasLayer/Items.get_children():
		slot.display()

