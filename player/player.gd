extends CharacterBody2D
class_name Player

const TILE_SIZE = 16

var _movement_cooldown := .25
var _movement_cooldown_timer := 0.0

var _velocity := Vector2.ZERO

func _ready() -> void:
	position = position.snapped(Vector2.ONE * TILE_SIZE) - Vector2(8, 8)

func _unhandled_input(event: InputEvent) -> void:
	var hdir := Input.get_axis("player_left", "player_right")
	var vdir := Input.get_axis("player_up", "player_down")
	
	# improvement? check the latest key, if its W/S, set hdir to 0, if A/D set vdir to 0.
	
	if hdir != 0 && vdir != 0:
		vdir = 0

	_velocity = Vector2(hdir, vdir)

func _process(delta: float) -> void:
	if !canMove():
		_movement_cooldown_timer += delta
		
func _physics_process(delta: float) -> void:
	if canMove() && _velocity != Vector2.ZERO:
		move(_velocity)

func move(vel: Vector2):
	position += vel * TILE_SIZE
	_movement_cooldown_timer = 0
	
func canMove() -> bool:
	return _movement_cooldown_timer >= _movement_cooldown
