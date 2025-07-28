class_name TimedButton extends StaticBody2D

signal on_changed(active: bool)

@export var reversed := false
@export var seconds := 5

var m_active := false
var m_player: Player

@onready var m_sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var m_timer: Timer = $Timer
@onready var m_transmitter: SignalTransmitter = $SignalTransmitterNode

func _ready() -> void:
	await get_tree().process_frame
	m_player = GameManager.player
	
	if reversed:
		m_active = true
	
	_change_animation()

func _get_signal_as_int() -> int:
	return 1 if m_active else 0

func press_button():
	if !m_player._current_state == _get_signal_as_int():
		m_active = !m_active
		
		m_transmitter.send_signal(_get_signal_as_int())
		_change_animation()
		_player_switch_states()
		
		m_timer.start(seconds)

func _on_timer_timeout() -> void:
	m_active = !m_active
	
	_change_animation()
	_player_switch_states()
	
func _change_animation():
	if m_active:
		m_sprite.animation = "on"
	else:
		m_sprite.animation = "off"
		
func _player_switch_states():
	if m_player._current_state == m_player.State.One:
		m_player._current_state = m_player.State.Zero
	else:
		m_player._current_state = m_player.State.One
		
	m_player.run_animation()
