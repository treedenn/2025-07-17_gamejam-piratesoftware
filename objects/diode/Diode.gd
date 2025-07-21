extends Node2D

@export var is_on: bool = false
@export var expected_input: int = 1

signal diode_activated

func receive_input(value: int):
	if value == expected_input:
		is_on = true
		#update_visual()
		emit_signal("diode_activated")
		GameManager.load_next_level()

#func update_visual():
	# TODO: Make some Diode art Græs
	#var path = is_on ? "res://art/diode_on.png" : "res://art/diode_off.png"
	#$Sprite2D.texture = load(path)
