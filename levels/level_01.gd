class_name Level01 extends Node

@onready var m_grp1_switch1: Switch = $Grp1/Switch1
@onready var m_grp1_switch2: Switch = $Grp1/Switch2
@onready var m_grp1_and_gate: AndGate = $Grp1/AndGate

@onready var m_grp2_switch1: Switch = $Grp2/Switch1
@onready var m_grp2_btn1: TimedButton = $Grp2/Button1
@onready var m_grp2_xor_gate: XorGate = $Grp2/XorGate

@onready var m_diode: Diode = $Diode

func _wired():
	m_grp1_switch1.m_transmitter.set_receiver(m_grp1_and_gate.m_receiver1)
	m_grp1_switch2.m_transmitter.set_receiver(m_grp1_and_gate.m_receiver2)
	m_grp1_and_gate.m_transmitter.set_receiver(m_grp2_xor_gate.m_receiver1)
	
	m_grp2_switch1.m_transmitter.set_receiver(m_grp2_xor_gate.m_receiver2)
	m_grp2_btn1.m_transmitter.set_receiver(m_grp2_xor_gate.m_receiver1)
	m_grp2_xor_gate.m_transmitter.set_receiver(m_diode.m_receiver)

func _ready():
	_wired()
