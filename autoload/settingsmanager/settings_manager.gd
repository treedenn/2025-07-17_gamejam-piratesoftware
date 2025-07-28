extends Node


const DEFAULT_WINDOW_MODE_INDEX: int = 0
const DEFAULT_RESOLUTION_INDEX: int = 0
const DEFAULT_MASTER_VOLUME: float = 0.0
const DEFAULT_SFX_VOLUME: float = 0.0
const DEFAULT_MUTE_VOLUME: bool = false

var loaded_data: Dictionary = {}

var _window_mode_index: int = 0
var _resolution_index: int = 0
var _master_volume: float = 0.0
var _mute_volume: bool = false
var _sfx_volume: float = 0.0

func _ready() -> void:
	_set_default_settings()

func _set_default_settings():
	_window_mode_index = DEFAULT_WINDOW_MODE_INDEX
	_resolution_index = DEFAULT_RESOLUTION_INDEX
	_master_volume = DEFAULT_MASTER_VOLUME
	_mute_volume = DEFAULT_MUTE_VOLUME
	_sfx_volume = DEFAULT_SFX_VOLUME
	
func create_storage_dict() -> Dictionary:
	var settings_container_dict: Dictionary = {
		"window_mode_index": _window_mode_index,
		"resolution_index": _resolution_index,
		"masterVolume": _master_volume,
		"sfxVolume": _sfx_volume,
		"muteVolume": _mute_volume,
	}
	
	return settings_container_dict
	
func get_window_mode_index() -> int:
	if loaded_data == {}:
		return DEFAULT_WINDOW_MODE_INDEX
	return _window_mode_index
	
func get_resolution_index() -> int:
	if loaded_data == {}:
		return DEFAULT_RESOLUTION_INDEX
	return _resolution_index
	
func get_master_volume() -> float:
	if loaded_data == {}:
		return DEFAULT_MASTER_VOLUME
	return _master_volume

func get_sfx_volume() -> float:
	if loaded_data == {}:
		return DEFAULT_SFX_VOLUME
	return _sfx_volume

func get_mute_volume() -> bool:
	if loaded_data == {}:
		return DEFAULT_MUTE_VOLUME
	return _mute_volume
	
func on_window_mode_selected(index: int) -> void:
	_window_mode_index = index
	
func on_resolution_selected(index: int) -> void:
	_resolution_index = index
	
func on_master_volume_set(value: float) -> void:
	_master_volume = value

func on_sfx_volume_set(value: float) -> void:
	_sfx_volume = value
	
func on_mute_volume_set(toggled: bool) -> void:
	_mute_volume = toggled

func on_settings_data_loaded(data: Dictionary) -> void:
	loaded_data = data
	on_window_mode_selected(loaded_data._window_mode_index)
	on_resolution_selected(loaded_data._resolution_ndex)
	on_master_volume_set(loaded_data._master_volume)
	on_mute_volume_set(loaded_data._mute_volume)
	on_sfx_volume_set(loaded_data._sfx_volume)
