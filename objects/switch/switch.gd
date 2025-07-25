class_name Switch
extends StaticBody2D

# Maybe make an interactable node or class

@export var logic_gate: LogicGate
@export_enum("A", "B") var logic_input: int

signal on_changed(active: bool)
var _active := false

@onready var n_on_sprite: Sprite2D = $OnSprite
@onready var n_off_sprite: Sprite2D = $OffSprite

func _ready() -> void:
	_switch_sprites()

func toggle():
	_active = !_active
	_switch_sprites()
	
	if logic_gate != null:
		var active_int := _get_active_as_int()
		match logic_input:
			0: logic_gate.set_input_a(active_int)
			1: logic_gate.set_input_b(active_int)
				
	on_changed.emit(_active)

func _get_active_as_int() -> int:
	return 1 if _active else 0
	
func _switch_sprites():
	n_on_sprite.visible = _active
	n_off_sprite.visible = !_active
