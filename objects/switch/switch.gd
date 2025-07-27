class_name Switch
extends StaticBody2D

# Maybe make an interactable node or class
@export var _active := false
@export var logic_gate: LogicGate
@export var line_to_gate: Line2D
@export_enum("A", "B") var logic_input: int

signal on_changed(active: bool)


@onready var switch_sprite: Sprite2D = $SwitchSprite

var player: Player

func _ready() -> void:
	_switch_sprites()
	
	_update_logic_gate()
	
	await get_tree().process_frame
	player = GameManager.player

func toggle() -> void:
	if logic_gate != null:
		
		if !player._current_state == _get_active_as_int():
			_active = !_active
			
			var active_int := _get_active_as_int()
			
			_switch_sprites()
			
			match logic_input:
				0: 
					logic_gate.set_input_a(active_int)
					_player_switch_states()
					_toggle_line()
				1:
					logic_gate.set_input_b(active_int)
					_player_switch_states()
					_toggle_line()
					
func _get_active_as_int() -> int:
	return 1 if _active else 0
	
func _switch_sprites():
	if _active:
		switch_sprite.frame = 5
	if !_active:
		switch_sprite.frame = 6
	
func _toggle_line():
	if line_to_gate:
		if _active:
			line_to_gate.modulate = Color.RED
		else:
			line_to_gate.modulate = Color.WHITE
	
func _player_switch_states():
	if player._current_state == player.State.One:
		player._current_state = player.State.Zero
	else:
		player._current_state = player.State.One
		
	player.run_animation()
	
func _update_logic_gate():
	if logic_gate != null:
		
			
		var active_int := _get_active_as_int()
			
		match logic_input:
			0: 
				logic_gate.set_input_a(active_int)
				_toggle_line()
			1:
				logic_gate.set_input_b(active_int)
				_toggle_line()
	
