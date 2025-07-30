class_name Switch extends StaticBody2D

signal on_changed(active: bool)

# Maybe make an interactable node or class
@export var _active := false
@export var line_to_gate: Line2D

var player: Player
var start_up_done: bool = false

@onready var switch_sprite: Sprite2D = $SwitchSprite
@onready var m_transmitter: SignalTransmitter = $SignalTransmitterNode
@onready var sfx_player: AudioStreamPlayer = $SfxPlayer

func _ready() -> void:
	await get_tree().process_frame
	player = GameManager.player
	
	_switch_sprites()
	transmit()
	
	start_up_done = true
	
func toggle() -> void:
	if !player._current_state == _get_signal_as_int():
		_active = !_active
		
		transmit()
		
		_switch_sprites()
		_toggle_line()
		_player_switch_states()
		
func transmit():
	var signal_as_int := _get_signal_as_int()
	m_transmitter.send_signal(signal_as_int)
					
func _get_signal_as_int() -> int:
	return 1 if _active else 0
	
func _switch_sprites():
	if start_up_done == true:
		sfx_player.play()
		
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
