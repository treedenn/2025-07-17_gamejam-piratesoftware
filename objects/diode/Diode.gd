class_name Diode extends Node2D

@export var is_on: bool = false
@export var expected_input: int = 1
@export var gate_to_diode_line: Line2D

@onready var m_receiver: SignalReceiver = $SignalReceiverNode
@onready var diode_light: PointLight2D = $DiodeLight


signal diode_activated

func _ready() -> void:
	diode_light.enabled = false
	m_receiver.signal_changed.connect(receive_input)


func turn_on():
	is_on = true
	diode_light.enabled = true
	emit_signal("diode_activated")
	
	if gate_to_diode_line:
		gate_to_diode_line.modulate = Color.RED
	
func turn_off():
	is_on = false
	diode_light.enabled = false
	if gate_to_diode_line:
		gate_to_diode_line.modulate = Color.WHITE

func receive_input(value: int):
	if value == expected_input:
		turn_on()
		#update_visual()
		#GameManager.load_next_level()
	else:
		turn_off()

#func update_visual():
	# TODO: Make some Diode art Græs
	#var path = is_on ? "res://art/diode_on.png" : "res://art/diode_off.png"
	#$Sprite2D.texture = load(path)
