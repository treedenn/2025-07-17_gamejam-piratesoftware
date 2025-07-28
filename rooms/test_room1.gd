class_name Room extends Node2D

@onready var m_tilemap := $TileMapLayer
@onready var m_player := $Player
@onready var m_camera := $Camera2D

@onready var m_and_gate: AndGate = $Node/AndGate
@onready var m_switch1: Switch = $Node/Switch
@onready var m_switch2: Switch = $Node/Switch2
@onready var m_diode: Diode = $Node/Diode

var boundaries: Vector2i

func _wiring():
	m_switch1.m_transmitter.set_receiver(m_and_gate.m_receiver1)
	m_switch2.m_transmitter.set_receiver(m_and_gate.m_receiver2)
	m_and_gate.m_transmitter.set_receiver(m_diode.m_receiver)

func _ready() -> void:
	var rect: Rect2i = m_tilemap.get_used_rect()
	var tileSize: Vector2i = m_tilemap.tile_set.tile_size
	
	boundaries = Vector2i(rect.size.x * tileSize.x, rect.size.y * tileSize.y)
	m_camera.limit_left = 0
	m_camera.limit_top = 0
	m_camera.limit_right = boundaries.x
	m_camera.limit_bottom = boundaries.y
	
	_wiring()

func _process(delta: float) -> void:
	m_camera.position = m_player.position
