class_name LogicGate
extends Node2D

# This script in itself will not do anything.
# Use the gate variations with the logic to calculate the output.

@export var InputA: LogicGate
@export var InputB: LogicGate

signal output_changed(value: int)

var input_a: int = 0
var input_b: int = 0
var _output: int = -1  # -1 = undefined

func _ready() -> void:
	if InputA != null:
		InputA.output_changed.connect(set_input_a)
	if InputB != null:
		InputB.output_changed.connect(set_input_b)
		
	_update()

func set_input_a(a: int):
	print(a, " A | Input A ", input_a)
	if input_a != a:
		input_a = a
		_update()

func set_input_b(b: int):
	print(b, " B | Input B ", input_b)
	if input_b != b:
		input_b = b
		_update()
		
func _get_inputs() -> Vector2i:
	return Vector2i(input_a, input_b)

func get_output() -> int:
	return _output

func _set_output(output: int):
	if _output != output:
		_output = output
		emit_signal("output_changed", _output)
		#output_changed.emit(_output)

func _update():
	pass
