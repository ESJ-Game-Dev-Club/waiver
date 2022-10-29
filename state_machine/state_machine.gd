class_name StateMachine
extends KinematicBody2D # allows us to have the Player class inherit the StateMachine class


export var initial_state = NodePath() # first state that is run
var is_active = true setget set_is_active # allows us to stop the state machine

onready var _state: State = get_node(initial_state) setget set_state # the current state that is being ran
onready var _state_name = _state.name


func _ready():
	_state.enter()


func _unhandled_input(event):
	_state.unhandled_input(event)


func _physics_process(delta):
	_state.physics_process(delta)


func transition_to(target_state: Node):
	_state.exit() # allows specific functionality for when a state is exited
	_state = target_state
	_state_name = _state.name
	_state.enter()
	Global.emit_signal("player_state_changed", _state.name)


func set_is_active(value): # allows any node to stop or start state machine
	is_active = value
	set_physics_process(value) # stops time
	set_process_unhandled_input(value) # stops control
	set_block_signals(not value) # stops signals


func set_state(value): # don't use this function as it doesn't call enter(msg) or exit()
	_state = value
	_state_name = _state.name
