class_name Room
extends Node2D

@onready var _tilemap := $TileMapLayer
@onready var _player := $Player
@onready var _camera := $Camera2D

@onready var _andgate1: LogicGate = $AndGate1
@onready var _andgate2: LogicGate = $AndGate2
@onready var _timer := $Timer

var boundaries: Vector2i

func _ready() -> void:
	var rect: Rect2i = _tilemap.get_used_rect()
	var tileSize: Vector2i = _tilemap.tile_set.tile_size
	
	boundaries = Vector2i(rect.size.x * tileSize.x, rect.size.y * tileSize.y)
	_camera.limit_left = 0
	_camera.limit_top = 0
	_camera.limit_right = boundaries.x
	_camera.limit_bottom = boundaries.y

func _process(delta: float) -> void:
	_camera.position = _player.position


var _counter := 0
func _on_timer_timeout() -> void:
	#match _counter:
		#0:
			#_andgate1.set_input_a(1)
		#1:
			#_andgate1.set_input_b(1)
		#2:
			#_andgate2.set_input_b(1)
	#
	#print("========== Counter: ", _counter)
	#
	#var agi1 := _andgate1._get_inputs()
	#var ago1 := _andgate1.get_output()
	#
	#var agi2 := _andgate2._get_inputs()
	#var ago2 := _andgate2.get_output()
	#
	#print("And gate 1 inputs: ", agi1)
	#print("And gate 1 output: ", ago1)
	#print("And gate 1 inputs: ", agi2)
	#print("And gate 1 output: ", ago2)
	#
	#_counter += 1
	pass
