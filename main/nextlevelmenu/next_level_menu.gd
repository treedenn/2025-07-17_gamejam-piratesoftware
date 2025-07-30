extends Control
class_name NextLevelMenu

@onready var next_level_button: TextureButton = $NinePatchRect/VBoxContainer/NextLevelButton
@onready var settings_button: TextureButton = $NinePatchRect/VBoxContainer/SettingsButton
@onready var mainmenu_button: TextureButton = $NinePatchRect/VBoxContainer/MainmenuButton
@onready var exit_button: TextureButton = $NinePatchRect/VBoxContainer/ExitButton
@onready var sfx_player: AudioStreamPlayer = $SfxPlayer

@export var settings_menu: SettingsMenu

var level_completed: bool = false
var _is_open: bool = false
func _ready() -> void:
	visible = false

func _on_next_level_button_pressed() -> void:
	sfx_player.play()
	GameManager.load_next_level()
	
func _on_mainmenu_button_pressed() -> void:
	sfx_player.play()
	GameManager.return_to_menu()


func _on_exit_button_pressed() -> void:
	sfx_player.play()
	get_tree().quit()

func _on_settings_button_pressed() -> void:
	sfx_player.play()
	settings_menu.open_settings_menu()

func open_next_level_menu():
	if level_completed:
		if _is_open == false:
			visible = true
			_is_open = true
		
	
