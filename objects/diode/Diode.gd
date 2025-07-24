extends Node2D

@export var is_on: bool = false
@export var expected_input: int = 1

@onready var point_light_2d: PointLight2D = $PointLight2D

@onready var diode_sprite: Sprite2D = $DiodeSprite

signal diode_activated

func _ready() -> void:
	point_light_2d.visible = false

func receive_input(value: int):
	print("Diode - DIODE VALUE RECEIVED INPUT", value)
	
	if value == expected_input:
		point_light_2d.visible = true
		is_on = true
		#update_visual()
		emit_signal("diode_activated")
		#GameManager.load_next_level()

#func update_visual():
	# TODO: Make some Diode art Græs - Can also just do some Light2D action to show it being off or on
	#var path = is_on ? "res://art/diode_on.png" : "res://art/diode_off.png"
	#$Sprite2D.texture = load(path)
