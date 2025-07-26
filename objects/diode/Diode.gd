extends Node2D

@export var is_on: bool = false
@export var expected_input: int = 1

@onready var diode_light: PointLight2D = $DiodeLight

@export var logic_gate: LogicGate
@export var gate_to_diode_line: Line2D

signal diode_activated

func _ready() -> void:
	diode_light.enabled = false
	if logic_gate:
		logic_gate.output_changed.connect(receive_input)

func receive_input(value: int):
	print(value, " VALUE | EXPECTED ", expected_input)
	if value == expected_input:
		print("RIGHT VALUE")
		is_on = true
		diode_light.enabled = true
		gate_to_diode_line.modulate = Color.RED
		#update_visual()
		emit_signal("diode_activated")
		#GameManager.load_next_level()

#func update_visual():
	# TODO: Make some Diode art Græs
	#var path = is_on ? "res://art/diode_on.png" : "res://art/diode_off.png"
	#$Sprite2D.texture = load(path)
