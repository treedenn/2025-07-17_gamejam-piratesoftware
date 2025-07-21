extends CharacterBody2D
class_name Player

const TILE_SIZE = 16

@export var tilemap: TileMapLayer
@export var binary_value: int = 1
@export var _movement_cooldown := 0.25
@export var animation_duration := 0.20

var _moving := false
var _movement_cooldown_timer := 0.0

@onready var raycast := $RayCast2D

func _ready():
	position = position.snapped(Vector2.ONE * TILE_SIZE) + Vector2.ONE * 8

func _process(delta):
	if _movement_cooldown_timer > 0:
		_movement_cooldown_timer -= delta
		return

	if _moving:
		return

	var dir = get_input_direction()
	if dir != Vector2i.ZERO and canMove(dir):
		_moving = true
		move(dir)

func get_input_direction() -> Vector2i:
	var hdir = Input.get_axis("player_left", "player_right")
	var vdir = Input.get_axis("player_up", "player_down")
	var dir = Vector2i(hdir, vdir)
	if dir.x != 0 and dir.y != 0:
		dir.y = 0
	return dir

func move(dir: Vector2i):
	var target = position + Vector2(dir) * TILE_SIZE
	var tween = create_tween()
	tween.tween_property(self, "position", target, animation_duration).set_trans(Tween.TRANS_SINE)

	_movement_cooldown_timer = _movement_cooldown
	await tween.finished
	_moving = false

func canMove(dir: Vector2i) -> bool:
	raycast.target_position = dir * TILE_SIZE
	raycast.force_raycast_update()
	return !raycast.is_colliding() and _movement_cooldown_timer <= 0
