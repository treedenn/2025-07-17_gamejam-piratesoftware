extends CharacterBody2D
class_name Player

const TILE_SIZE = 16

@export var tilemap: TileMapLayer

var _moving := false
var _movement_cooldown := 0.25
var _movement_cooldown_timer := 0.0
var _velocity := Vector2.ZERO

@onready var raycast := $RayCast2D

func _init() -> void:
	floor_snap_length = TILE_SIZE

func _ready() -> void:
	position = position.snapped(Vector2.ONE * TILE_SIZE) + Vector2.ONE * 8

func _unhandled_input(event: InputEvent) -> void:
	var hdir := Input.get_axis("player_left", "player_right")
	var vdir := Input.get_axis("player_up", "player_down")
	_velocity = Vector2i(hdir, vdir)
	
	# player is pressing both directions, priotize left/right
	if _velocity.x != 0 && _velocity.y != 0:
		_velocity.y = 0
	
	# do not call below if an actual player movement action has been pressed
	if !_velocity.is_zero_approx():
		if canMove():
			_moving = true
			move(_velocity)

func _process(delta: float) -> void:
	if _movement_cooldown_timer > 0:
		_movement_cooldown_timer -= delta

func move(vel: Vector2):
	var animation_speed := .25
	var tween = create_tween()
	tween.tween_property(self, "position", position + vel * TILE_SIZE, animation_speed).set_trans(Tween.TRANS_SINE)
	
	_movement_cooldown_timer = _movement_cooldown
	
	await tween.finished
	
	_moving = false
	
	
func canMove() -> bool:
	if _moving:
		return false
		
	# collision detection against the tilemap physical layer
	raycast.target_position = _velocity * TILE_SIZE
	if raycast.is_colliding():
		return false
		
	return _movement_cooldown_timer <= 0
