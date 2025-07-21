extends LogicGate
class_name NandGate

func _update_output():
	var new_output = ~(input_a & input_b) & 1
	if new_output != output:
		output = new_output
		emit_signal("output_changed", output)
