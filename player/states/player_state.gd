class_name PlayerState
extends State


var player: Player


func enter():
	player = Global.player

func _ready():
	player = Global.player

func unhandled_input(event):
	if event.is_action_pressed("fire") and player.inventory_array[Pickup.ItemType.WEAPON]:
		player.inventory_array[Pickup.ItemType.WEAPON].fire()
	if event.is_action_pressed("fire_alt") and player.inventory_array[Pickup.ItemType.SPECIAL]:
		player.inventory_array[Pickup.ItemType.SPECIAL].fire()

func on_pickup(area):
	area.queue_free()
	player.pickup_item(area.item_type, area.inventory_icon, area.item_scene_path)

func _get_input() -> Vector2: # returns normalized direction input
	var input = Vector2.ZERO

	if Input.is_action_pressed("move_up"):
		input.y -= 1
	if Input.is_action_pressed("move_down"):
		input.y += 1
	if Input.is_action_pressed("move_left"):
		input.x -= 1
	if Input.is_action_pressed("move_right"):
		input.x += 1
	
	return input.normalized()

func physics_process(_delta):
	# if player is touching enemy
	if player.get_node("HitDetection").get_overlapping_bodies().size() > 0:
		player.health -= 1
		
		if player.health == 0:
			player.queue_free() # crash the game on loss
		
		player.transition_to(player.get_node("States/Staggered"))
		return
	
	player.velocity += _get_move(_get_input(), player.normal_accel * player.get_modifier("speed"), player.normal_speed * player.get_modifier("speed"))
	player.velocity = player.move_and_slide(player.velocity)


func _get_move(direction: Vector2, acceleration: int, max_speed: int):
	var goal = direction * max_speed # the desired direction
	var to_goal = goal - player.velocity # direction from velocity to desired direction
	var accel_speed = min(acceleration, to_goal.length()) # clamp the speed
	return to_goal.normalized() * accel_speed # return the movement
