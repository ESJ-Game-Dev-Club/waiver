extends CanvasItem

export(StreamTexture) var texture
export(int, LAYERS_2D_PHYSICS) var layer := 8
export(int, LAYERS_2D_PHYSICS) var mask := 1

var enemies: Array = []

func _ready():
	spawn_enemy(Vector2.ZERO)

func _physics_process(_delta):
	# individual enemy logic is handled under here
	for enemy in enemies:
		enemy = enemy as Enemy
		print(enemy.transform)
		enemy.velocity = Vector2(1, 1)
		enemy.transform.origin += enemy.velocity
		Physics2DServer.area_set_transform(enemy.area_rid, enemy.transform)
		VisualServer.canvas_item_set_transform(enemy.ci_rid, enemy.transform)

#func _physics_process(_delta):
#	enemies[0].velocity.x = 1
#	enemies[0].position += enemies[0].velocity
#	Physics2DServer.body_set_state(enemies[0].body_rid, Physics2DServer.BODY_STATE_TRANSFORM, Transform2D(0, enemies[0].position))
#	VisualServer.canvas_item_set_transform(enemies[0].ci_rid, Transform2D(0, enemies[0].position))

# create the enemy and append the enemy object to the enemies array
func spawn_enemy(position: Vector2) -> void:
	var enemy := Enemy.new()
	enemy.transform.origin = position
	
	# create the texture
	var ci_rid = VisualServer.canvas_item_create()
	enemy.ci_rid = ci_rid
	VisualServer.canvas_item_set_parent(ci_rid, get_canvas_item())
	var tex = texture
	var rect = Rect2(Vector2(-tex.get_size().x / 2, -tex.get_size().y / 2), tex.get_size())
	VisualServer.canvas_item_add_texture_rect(ci_rid, rect, tex)
	# create shape
	var shape_rid = Physics2DServer.circle_shape_create()
	enemy.shape_rid = shape_rid
	Physics2DServer.shape_set_data(shape_rid, 16)
	# create area
	var area_rid = Physics2DServer.area_create()
	enemy.area_rid = area_rid
	Physics2DServer.area_add_shape(area_rid, shape_rid)
	Physics2DServer.area_set_space(area_rid, get_world_2d().space)
	Physics2DServer.area_set_collision_layer(area_rid, layer)
	Physics2DServer.area_set_collision_mask(area_rid, mask)
	Physics2DServer.area_set_monitor_callback(area_rid, self, "_area_callback")
	
	enemies.append(enemy)
