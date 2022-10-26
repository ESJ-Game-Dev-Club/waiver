class_name Player
extends KinematicBody2D


var current_state = States.NORMAL
enum States {
	NORMAL,
	STAGGERED,
	ATTACKING,
}

var normal_speed = 100
var staggered_speed = 110 # makes it easy for player to escape
var attacking_speed = 50

var health = 3

var inventory_list : Array= ["res://resources/item_images/knife1.png", null, null, null]

func _ready():
	GlobalVars.player = self

func _physics_process(delta):
	$WeaponOrigin.look_at(get_global_mouse_position())
	
	match current_state:
		States.NORMAL: # basic movement; detect if enemies touch
			_normal()
		States.STAGGERED: # speedier movement; flash in and out
			_staggered()
		States.ATTACKING: # slower movement; detects if enemies touch
			_attacking()


func _normal():
	_move(normal_speed)
	
	if _hit_detect():
		return
	
	if Input.is_action_just_pressed("attack"):
		if $WeaponOrigin.get_child(0).fire(): # attempt to fire weapon (returns bool about if it did)
			$AttackTimer.start($WeaponOrigin.get_child(0).atk_time)
			current_state = States.ATTACKING
			return


func _staggered():
	_move(staggered_speed)

func _on_StaggerTimer_timeout(): # stop flashing and go back to normal
	$FlashTimer.stop()
	show()
	current_state = States.NORMAL

func _on_FlashTimer_timeout(): # flash
	visible = not visible
	$FlashTimer.start()


func _attacking():
	_move(attacking_speed)
	
	if _hit_detect():
		$AttackTimer.stop()
		return

func _on_AttackTimer_timeout():
	current_state = States.NORMAL


func _move(speed):
	move_and_slide(_get_input() * speed)

func _hit_detect(): # detects if enemies touch player and staggers
	if $HitDetection.get_overlapping_bodies().size() > 0:
		health -= 1
		
		if health == 0:
			queue_free()
		
		$StaggerTimer.start()
		# flash when staggered
		hide()
		$FlashTimer.start()
		current_state = States.STAGGERED
		return true
	else:
		return false

func _get_input() -> Vector2:
	var input = Vector2.ZERO
	
	if Input.is_action_pressed("move_up"):
		input.y -= 1
	if Input.is_action_pressed("move_down"):
		input.y += 1
	if Input.is_action_pressed("move_left"):
		input.x -= 1
	if Input.is_action_pressed("move_right"):
		input.x += 1
	if Input.is_action_just_pressed("ui_accept"): ############################################## Test statement for Inventory remove later! #########################################################
		GlobalVars.emit_signal("item_change", 0, inventory_list[0])
	
	return input.normalized()
