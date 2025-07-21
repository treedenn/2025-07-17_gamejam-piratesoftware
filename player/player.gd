extends CharacterBody2D
class_name Player

const TILE_SIZE = 16

@export var tilemap: TileMapLayer
@export var binary_value: int = 1
@export var _movement_cooldown := 0.25
@export var animation_duration := 0.25

var _movement_cooldown_timer := 0.0
var _moving := false

@onready var raycast := $RayCast2D

func _init() -> void:
	floor_snap_length = TILE_SIZE

func _ready() -> void:
	position = position.snapped(Vector2.ONE * TILE_SIZE) + Vector2.ONE * 8

func _unhandled_input(event: InputEvent) -> void:
	var hdir = Input.get_axis("player_left", "player_right")
	var vdir = Input.get_axis("player_up", "player_down")
	var dir = Vector2i(hdir, vdir)

	if dir.x != 0 and dir.y != 0:
		dir.y = 0

	if dir != Vector2i.ZERO and canMove(dir):
		_moving = true
		move(dir)

func _process(delta: float) -> void:
	if _movement_cooldown_timer > 0:
		_movement_cooldown_timer -= delta

func move(vel: Vector2i):
	var tween = create_tween()
	tween.tween_property(self, "position", position + Vector2(vel) * TILE_SIZE, animation_duration)

	_movement_cooldown_timer = _movement_cooldown

	await tween.finished

	_moving = false

func canMove(dir: Vector2i) -> bool:
	if _moving:
		return false

	raycast.target_position = dir * TILE_SIZE
	raycast.force_raycast_update()
	return !raycast.is_colliding() and _movement_cooldown_timer <= 0
