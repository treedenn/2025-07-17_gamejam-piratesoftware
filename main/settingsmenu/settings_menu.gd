extends Control

#-------------VARIABLES RELATED TO... WELL, OTHER OPTIONS MENU UI STUFF
@onready var exit_button = $SettingsContainer/HBoxContainer6/ExitButton

#-------------VARIABLES RELATED TO AUDIO SETTINGS--------------
@onready var volume_slider = $SettingsContainer/HBoxContainer3/MasterVolumeSlider
@onready var mute_check = $SettingsContainer/HBoxContainer5/MuteCheck


#------------VARIABLES RELATED TO VIDEO SETTINGS--------------
@onready var resolution_button = $SettingsContainer/HBoxContainer2/ResolutionOption
@onready var window_mode_button = $SettingsContainer/HBoxContainer/WindowOption


#------------VARIABLES ON WHERE TO RETURN TO---------------
#@onready var returnToPause: bool = false

#----------------SIGNALS-----------------------


#Ready function: Calls loadData, signals, and sets process to false on 
func _ready() -> void:
	#exit_button.button_down.connect(exit_pressed)
	call_deferred("load_data")
	set_process(false)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if volume_slider.value == 0:
		AudioServer.set_bus_mute(0, true)
		
	elif mute_check.button_pressed == true:
		AudioServer.set_bus_mute(0, true)
		
	else:
		AudioServer.set_bus_mute(0, false)
			

func load_data() -> void:
	_on_master_volume_slider_value_changed(SettingsManager.get_master_volume())
	volume_slider.set_value_no_signal(SettingsManager.get_master_volume())
	
	_on_mute_check_toggled(SettingsManager.get_mute_volume())
	mute_check.set_pressed_no_signal(SettingsManager.get_mute_volume())
	
	_on_resolution_option_item_selected(SettingsManager.get_resolution_index())
	resolution_button.select(SettingsManager.get_resolution_index())
	
	_on_window_option_item_selected(SettingsManager.get_window_mode_index())
	window_mode_button.select(SettingsManager.get_window_mode_index())

func _on_master_volume_slider_value_changed(value: float) -> void:
	AudioServer.set_bus_volume_db(0, value)


func _on_mute_check_toggled(toggled_on: bool) -> void:
	AudioServer.set_bus_mute(0,toggled_on)


func _on_window_option_item_selected(index: int) -> void:
	match index:
		0:
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
		1:
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
		2:
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_EXCLUSIVE_FULLSCREEN)


func _on_resolution_option_item_selected(index: int) -> void:
	match index:
		0:
			DisplayServer.window_set_size(Vector2i(1920, 1080))
		1:
			DisplayServer.window_set_size(Vector2i(1600, 900))
		2:
			DisplayServer.window_set_size(Vector2i(1280, 720))
		3:
			DisplayServer.window_set_size(Vector2i(1152, 648))
