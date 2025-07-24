extends CharacterBody2D
class_name Player

enum State {Zero, One}

const TILE_SIZE = 16

@export var tilemap: TileMapLayer
@export var binary_value: int = 1
@export var _movement_cooldown := 0.25
@export var animation_duration := 0.20

@onready var interact_area: Area2D = $Area2D
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var raycast := $RayCast2D

var _moving := false
var _movement_cooldown_timer := 0.0

var _current_state: State
var _animation_chosen: int = 1
var _max_anim_roll_value: int = 10
var _min_anim_roll_value: int = 1
var _nothing_anim_value: int = 6

var _interacted_node: Node2D

func _ready():
	position = position.snapped(Vector2.ONE * TILE_SIZE) + Vector2.ONE * 8
	
	_current_state = State.One

func _unhandled_key_input(event: InputEvent) -> void:
	if event.is_action_pressed("player_interact"):
		if is_instance_valid(_interacted_node):
			_handle_interaction()

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
	
	# Roll, at random, for the animation to run - if it rolls 6+ (_nothing_anim_value), it picks "Nothing"
	#for the animation, otherwise plays one of the others. Done this way to weight towards "Nothing".
	if not animation_player.is_playing():
		_animation_chosen = randi_range(_min_anim_roll_value,_max_anim_roll_value)
		if _animation_chosen >= _nothing_anim_value:
			_animation_chosen = _nothing_anim_value
		run_animation()

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

# Function to run the animation based on previously rolled animation and current state
func run_animation():
	var state_string = State.keys()[_current_state]
	
	print(_animation_chosen, " This is chosen anim")
	print(state_string)
	
	match _animation_chosen:
		1:
			animation_player.play(state_string + "Blink")
		2:
			animation_player.play(state_string + "Eyebrows")
		3:
			animation_player.play(state_string + "RaisedBoth")
		4:
			animation_player.play(state_string + "RaisedLeft")
		5: 
			animation_player.play(state_string + "RaisedRight")
		6:
			animation_player.play(state_string + "Nothing")

func can_interact() -> bool:
	return true

func _handle_interaction() -> void:
	if can_interact():
		if _interacted_node is Switch:
			_interacted_node.toggle()

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body is Switch:
		_interacted_node = body

func _on_area_2d_body_exited(body: Node2D) -> void:
	if _interacted_node == body:
		_interacted_node = null
