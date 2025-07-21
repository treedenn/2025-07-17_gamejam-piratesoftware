extends LogicGate
class_name AndGate

func _update_output():
	var new_output = input_a & input_b
	if new_output != output:
		output = new_output
		emit_signal("output_changed", output)
