class_name Room
extends Node2D

@onready var _tilemap := $TileMapLayer
@onready var _player := $Player
@onready var _camera := $Camera2D

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
