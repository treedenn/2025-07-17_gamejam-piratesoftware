extends Control
class_name SettingsMenu

#-------------UI BUTTONS
@onready var exit_button = $SettingsContainer/HBoxContainer6/ExitButton

#-------------AUDIO SETTINGS--------------
@onready var volume_slider = $SettingsContainer/HBoxContainer3/MasterVolumeSlider
@onready var mute_check = $SettingsContainer/HBoxContainer5/MuteCheck


#------------VIDEO SETTINGS--------------
@onready var window_mode_button = $SettingsContainer/HBoxContainer/WindowOption

@onready var sfx_player: AudioStreamPlayer = $SfxPlayer

var _is_open: bool = false
var _start_up_done: bool = false

#Ready function: Calls loadData, signals, and sets process to false on 
func _ready() -> void:
	#exit_button.button_down.connect(exit_pressed)
	call_deferred("load_data")
	set_process(false)
	visible = false
	
	await get_tree().process_frame
	_start_up_done = true

func load_data() -> void:
	_on_master_volume_slider_value_changed(SettingsManager.get_master_volume())
	volume_slider.set_value_no_signal(SettingsManager.get_master_volume())
	
	_on_mute_check_toggled(SettingsManager.get_mute_volume())
	mute_check.set_pressed_no_signal(SettingsManager.get_mute_volume())
	
	_on_window_option_item_selected(SettingsManager.get_window_mode_index())
	window_mode_button.select(SettingsManager.get_window_mode_index())

func _on_master_volume_slider_value_changed(value: float) -> void:
	_play_sfx()
	AudioServer.set_bus_volume_db(0, value)


func _on_mute_check_toggled(toggled_on: bool) -> void:
	_play_sfx()
	AudioServer.set_bus_mute(0,toggled_on)


func _on_window_option_item_selected(index: int) -> void:
	match index:
		0:
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
			_play_sfx()
		1:
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
			_play_sfx()
		2:
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_EXCLUSIVE_FULLSCREEN)
			_play_sfx()

func _play_sfx():
	if _start_up_done:
		sfx_player.play()

func _on_exit_button_pressed() -> void:
	if _is_open:
		visible = false
		_is_open = false
		sfx_player.play()
