extends MovementScript


export(int) var acceleration: int = 20
export(int) var max_speed: int = 40
export(float) var change_time: float = 2.5 # time it takes to change the direction
export(float) var time_random: float = 1 # how much the time will be randomized

var cycle_time
var time_elapsed: float = 0
var rng = RandomNumberGenerator.new()
var direction: Vector2 = Vector2.UP


func _ready():
	rng.randomize()
	direction = direction.rotated(deg2rad(rng.randf_range(0, 360))) # inital direction is random
	cycle_time = change_time + rng.randf_range(0, time_random)

func run(delta):
	time_elapsed += delta
	if time_elapsed > cycle_time:
		time_elapsed -= cycle_time
		cycle_time = change_time + rng.randf_range(0, time_random) # randomize time between changes
		rng.randomize()
		direction = direction.rotated(deg2rad(rng.randf_range(-90, 90))) # rotate em
	
	enemy.velocity += _get_move(direction, acceleration, max_speed)
	enemy.velocity = enemy.move_and_slide(enemy.velocity)
