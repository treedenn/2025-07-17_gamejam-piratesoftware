extends LogicGate
class_name NandGate

func _update_output():
	var new_output := ~(input_a & input_b) & 1
	_set_output(new_output)
