extends StateMachine
class_name Enemy


export var health: int = 3
export var damage: int = 1
export var knockback: int = 300 # how much the enemy is knocked back when hit

var velocity: Vector2 = Vector2.ZERO


func hit(dmg): # passes damage values to the current enemy state
	_state.hit(dmg)
