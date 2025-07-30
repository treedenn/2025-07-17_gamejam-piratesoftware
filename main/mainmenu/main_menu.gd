extends Node2D

@onready var button_container: VBoxContainer = $MainMenuCanvas/ButtonContainer
@onready var start_button: TextureButton = $MainMenuCanvas/ButtonContainer/StartButton
@onready var level_button: TextureButton = $MainMenuCanvas/ButtonContainer/LevelButton
@onready var options_button: TextureButton = $MainMenuCanvas/ButtonContainer/OptionsButton
@onready var exit_button: TextureButton = $MainMenuCanvas/ButtonContainer/ExitButton
@onready var level_picker: Control = $MainMenuCanvas/LevelPicker
@onready var settings_menu: Control = $MainMenuCanvas/SettingsMenu
@onready var sfx_player: AudioStreamPlayer = $SfxPlayer


func _on_exit_button_pressed() -> void:
	sfx_player.play()
	get_tree().quit()

func _on_start_button_pressed() -> void:
	sfx_player.play()
	GameManager.safe_load_level.call_deferred(GameManager.current_level_index)
	
func _on_options_button_pressed() -> void:
	settings_menu.open_settings_menu()
	sfx_player.play()

func _on_level_button_pressed() -> void:
	sfx_player.play()
	level_picker.visible = true
