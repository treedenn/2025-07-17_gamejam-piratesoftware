extends Control
class_name PauseMenu

@onready var continue_button: TextureButton = $ButtonContainer/ContinueButton
@onready var options_button: TextureButton = $ButtonContainer/OptionsButton
@onready var exit_button: TextureButton = $ButtonContainer/ExitButton
@onready var sfx_player: AudioStreamPlayer = $SfxPlayer

@export var settings_menu: SettingsMenu

var _is_open: bool = false

func _ready() -> void:
	visible = false
	settings_menu.visible = false

func _unhandled_input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("pause"):
		if _is_open == false:
			sfx_player.play()
			visible = true
			_is_open = true
		else:
			sfx_player.play()
			_close_pause_menu()

func _close_pause_menu():
	if _is_open:
		visible = false
		_is_open = false
		settings_menu.close_settings_menu()

func _on_continue_button_pressed() -> void:
	sfx_player.play()
	_close_pause_menu()
		
func _on_exit_button_pressed() -> void:
	sfx_player.play()
	get_tree().quit()

func _on_options_button_pressed() -> void:
	sfx_player.play()
	settings_menu.open_settings_menu()
