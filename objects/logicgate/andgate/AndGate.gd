extends LogicGate
class_name AndGate


func _update_output():
	var new_output := input_a & input_b
	print(new_output, " AND GATE NEW OUTPUT")
	_set_output(new_output)
