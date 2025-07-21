extends Node2D

class_name LogicGate

signal output_changed(value: int)

var input_a: int = 0
var input_b: int = 0
var output: int = -1  # -1 = undefined

func set_inputs(a: int, b: int):
	input_a = a
	input_b = b
	_update_output()

func _update_output():
	# Overridden in derived classes
	pass
