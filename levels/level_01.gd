class_name Level01 extends Node

#Group 1: Switch1 & AndGate
@onready var m_grp1_switch1: Switch = $SubViewport/SubViewport/Grp1/Switch1
@onready var m_grp1_and_gate: AndGate = $SubViewport/SubViewport/Grp1/AndGate

#Group 2: Switch1, Switch2 & XorGate
@onready var m_grp2_switch1: Switch = $SubViewport/SubViewport/Grp2/Switch1
@onready var m_grp2_switch2: Switch = $SubViewport/SubViewport/Grp2/Switch2
@onready var m_grp2_xor_gate: XorGate = $SubViewport/SubViewport/Grp2/XorGate
@onready var sub_viewport_container: SubViewportContainer = $SubViewport

@onready var m_diode: Diode = $SubViewport/SubViewport/Diode

@onready var next_level_menu: NextLevelMenu = $SubViewport/CanvasLayer/NextLevelMenu

@onready var tile_map_layer: TileMapLayer = $SubViewport/SubViewport/TileMapLayer
@onready var tile_map_layer_2: TileMapLayer = $SubViewport/SubViewport/TileMapLayer2


func _ready() -> void:
	m_diode.diode_activated.connect(_on_level_completed)
	_wired()
	
	TilemapSaveManager.restore_level_tilemaps(0, tile_map_layer, tile_map_layer_2)
	
func _exit_tree() -> void:
	# Save tilemap data before leaving this level
	if tile_map_layer and tile_map_layer_2:
		TilemapSaveManager.save_level_tilemaps(0, tile_map_layer, tile_map_layer_2)
		
func _wired():
	#Switches inputs into XOrGate and XOrGate inputs into AndGate
	m_grp2_switch1.m_transmitter.set_receiver(m_grp2_xor_gate.m_receiver1)
	m_grp2_switch2.m_transmitter.set_receiver(m_grp2_xor_gate.m_receiver2)
	m_grp2_xor_gate.m_transmitter.set_receiver(m_grp1_and_gate.m_receiver1)
	
	#Switch inputs into AndGate and AndGate inputs in Diode
	m_grp1_switch1.m_transmitter.set_receiver(m_grp1_and_gate.m_receiver2)
	m_grp1_and_gate.m_transmitter.set_receiver(m_diode.m_receiver)

func _on_level_completed():
	next_level_menu.level_completed = true
	
	next_level_menu.open_next_level_menu()
	
