class_name LogicGate extends Node2D

@export var reversed := false
@export var transmit_to: SignalReceiver

@onready var m_receiver1: SignalReceiver = $SignalReceiverNode1
@onready var m_receiver2: SignalReceiver = $SignalReceiverNode2
@onready var m_transmitter: SignalTransmitter = $SignalTransmitterNode

func _ready():
	m_receiver1.signal_changed.connect(_on_input_changed)
	m_receiver2.signal_changed.connect(_on_input_changed)
		
	_update_sprite()
	_update()
	
func _on_input_changed(new_signal: int):
	_update_sprite()
	_update()

func _update_sprite():
	pass

func _update():
	pass
