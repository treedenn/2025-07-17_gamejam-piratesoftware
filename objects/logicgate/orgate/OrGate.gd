extends LogicGate
class_name OrGate

func _update_output():
	var new_output := input_a | input_b
	_set_output(new_output)
