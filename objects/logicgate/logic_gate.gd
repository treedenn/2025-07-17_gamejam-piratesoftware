class_name LogicGate extends StaticBody2D

@export var reversed := false
@export var transmit_to: SignalReceiver
@export var line_to_gate: Line2D

@onready var m_receiver1: SignalReceiver = $SignalReceiverNode1
@onready var m_receiver2: SignalReceiver = $SignalReceiverNode2
@onready var m_transmitter: SignalTransmitter = $SignalTransmitterNode

func _ready():
	m_receiver1.signal_changed.connect(_on_input_changed)
	m_receiver2.signal_changed.connect(_on_input_changed)
	
	# HACK: Awaits a process frame to make sure the level is loaded prior to updating the logic gates
	await get_tree().process_frame
	_update_sprite()
	_update()
	
func _on_input_changed(new_signal: int):
	print(new_signal, " receiving new signal to ", name)
	_update_sprite()
	_update()

func _update_sprite():
	pass

func _update():
	pass
