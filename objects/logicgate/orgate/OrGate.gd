extends LogicGate
class_name OrGate

@onready var sprite: AnimatedSprite2D = $AnimatedSprite2D

func _update_sprite():
	var frameName := "none"
	if input_a == 1 && input_b == 0:
		frameName = "inputa"
	if input_a == 0 && input_b == 1:
		frameName = "inputb"
	if input_a == 1 && input_b == 1:
		frameName = "full"
	sprite.animation = frameName

func _update():
	var new_output := input_a | input_b
	_set_output(new_output)
	_update_sprite()
