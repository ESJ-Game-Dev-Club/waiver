#extends CanvasItem
#
#export var tex: StreamTexture
#
#var body
#var shape
#
#var texture
#var ci_rid
#
#
#func _body_moved(state, index):
#	print(body.get_id())
#	state.linear_velocity = Vector2.LEFT * 10
#	VisualServer.canvas_item_set_transform(ci_rid, state.transform)
#
#
#func _ready():
#	# create sprite
#	ci_rid = VisualServer.canvas_item_create()
#	VisualServer.canvas_item_set_parent(ci_rid, get_canvas_item())
##	texture = load("res://icon.png")
##	print(texture.get_class())
#	var texture = tex
#	VisualServer.canvas_item_add_texture_rect(ci_rid, Rect2(texture.get_size() / 2, texture.get_size()), texture)
#
#	# create rigidbody
#	body = Physics2DServer.body_create()
#	Physics2DServer.body_set_mode(body, Physics2DServer.BODY_MODE_RIGID)
#	shape = RectangleShape2D.new()
#	shape.extents = Vector2(10, 10)
#	Physics2DServer.body_add_shape(body, shape)
#	Physics2DServer.body_set_space(body, get_world_2d().space)
#	Physics2DServer.body_set_state(body, Physics2DServer.BODY_STATE_TRANSFORM, Transform2D(0, Vector2(10, 20)))
#	Physics2DServer.body_set_force_integration_callback(body, self, "_body_moved", 0)
#	Physics2DServer.body_set_omit_force_integration(body, true)

extends CanvasItem

export(StreamTexture) var texture
export(int, LAYERS_2D_PHYSICS) var layer := 8
export(int, LAYERS_2D_PHYSICS) var mask := 1

var enemies: Array = []

func _ready():
	spawn_enemy(Vector2.ZERO)

func _physics_process(delta):
	enemies[0].velocity.x = 1
	enemies[0].position += enemies[0].velocity
	Physics2DServer.body_set_state(enemies[0].body_rid, Physics2DServer.BODY_STATE_TRANSFORM, Transform2D(0, enemies[0].position))
	VisualServer.canvas_item_set_transform(enemies[0].ci_rid, Transform2D(0, enemies[0].position))

# create the enemy and append the enemy object to the enemies array
func spawn_enemy(position: Vector2) -> void:
	var enemy := Enemy.new()
	enemy.position = position
	
	# create the texture
	var ci_rid = VisualServer.canvas_item_create()
	enemy.ci_rid = ci_rid
	VisualServer.canvas_item_set_parent(ci_rid, get_canvas_item())
	var tex = texture
	var rect = Rect2(Vector2(-tex.get_size().x / 2, -tex.get_size().y / 2), tex.get_size())
	VisualServer.canvas_item_add_texture_rect(ci_rid, rect, tex)
	
	# create the body and shape
	var body_rid = Physics2DServer.body_create()
	enemy.body_rid = body_rid
	Physics2DServer.body_set_mode(body_rid, Physics2DServer.BODY_MODE_KINEMATIC)
	var shape_rid = Physics2DServer.circle_shape_create()
	enemy.shape_rid = shape_rid
	Physics2DServer.shape_set_data(shape_rid, 16)
	Physics2DServer.body_add_shape(body_rid, shape_rid)
	Physics2DServer.body_set_space(body_rid, get_world_2d().space)
	Physics2DServer.body_set_collision_layer(body_rid, layer)
	Physics2DServer.body_set_collision_mask(body_rid, mask)
	
	enemies.append(enemy)
