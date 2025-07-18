extends CharacterBody2D
class_name Player

const TILE_SIZE = 16

var _movement_cooldown := 0.25
var _movement_cooldown_timer := 0.0

var _velocity := Vector2.ZERO

var _anim_speed := 0.25

var _moving := false

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
	var tween = create_tween()
	tween.tween_property(self, "position", position + vel * TILE_SIZE, _anim_speed).set_trans(Tween.TRANS_SINE)
	# Keeping this here for future references until no longer necessary
	# TODO: Remove
	#position += vel * TILE_SIZE
	
	_moving = true
	_movement_cooldown_timer = 0
	
	await tween.finished
	
	_moving = false
	
	
	
func canMove() -> bool:
	if _moving:
		return false
		
	return _movement_cooldown_timer >= _movement_cooldown
