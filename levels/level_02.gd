extends Node2D

#GROUP 1
@onready var switch_1: Switch = $Grp1/Switch1
@onready var switch_2: Switch = $Grp1/Switch2
@onready var and_gate: AndGate = $Grp1/AndGate
@onready var or_gate: OrGate = $Grp1/OrGate
@onready var not_gate: NotGate = $Grp1/NOTGate

#GROUP 2
@onready var switch_3: Switch = $Grp2/Switch3
@onready var switch_4: Switch = $Grp2/Switch4
@onready var xor_gate: XorGate = $Grp2/XorGate
@onready var xor_gate_2: XorGate = $Grp2/XorGate2
@onready var and_gate_2: AndGate = $Grp2/AndGate2
@onready var win_sfx: AudioStreamPlayer = $WinSfx

@onready var m_diode: Diode = $Diode
@onready var tile_map_layer: TileMapLayer = $TileMapLayer
@onready var tile_map_layer_2: TileMapLayer = $TileMapLayer2

@onready var ui: CanvasLayer = $UI

@onready var next_level_menu: NextLevelMenu = ui.next_level_menu

func _ready() -> void:
	m_diode.diode_activated.connect(_on_level_completed)
	_wired()
	
	TilemapSaveManager.restore_level_tilemaps(1, tile_map_layer, tile_map_layer_2)
	
	
func _exit_tree() -> void:
	# Save tilemap data before leaving this level
	if tile_map_layer and tile_map_layer_2:
		TilemapSaveManager.save_level_tilemaps(1, tile_map_layer, tile_map_layer_2)
		
func _wired():
	#Switches inputs into XOrGate and XOrGate inputs into AndGate
	switch_1.m_transmitter.add_receiver(and_gate.m_receiver2)
	switch_2.m_transmitter.add_receiver(and_gate.m_receiver1)
	
	switch_2.m_transmitter.add_receiver(xor_gate.m_receiver2)
	switch_3.m_transmitter.add_receiver(xor_gate.m_receiver1)
	
	switch_3.m_transmitter.add_receiver(not_gate.m_receiver1)
	
	switch_4.m_transmitter.add_receiver(xor_gate_2.m_receiver1)
	xor_gate.m_transmitter.add_receiver(xor_gate_2.m_receiver2)
	
	and_gate.m_transmitter.add_receiver(or_gate.m_receiver2)
	not_gate.m_transmitter.add_receiver(or_gate.m_receiver1)
	print(or_gate.m_receiver1.name, " OR GATE M RECEIVER 1 ")

	xor_gate_2.m_transmitter.add_receiver(and_gate_2.m_receiver1)
	or_gate.m_transmitter.add_receiver(and_gate_2.m_receiver2)
	
	and_gate_2.m_transmitter.add_receiver(m_diode.m_receiver)

func _on_level_completed():
	next_level_menu.level_completed = true
	win_sfx.play()
	
	next_level_menu.open_next_level_menu()
