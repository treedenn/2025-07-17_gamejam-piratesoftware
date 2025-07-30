extends Control

@export var level_button: PackedScene
@onready var level_button_container: VBoxContainer = $LevelButtonContainer
@onready var nine_patch_rect: NinePatchRect = $NinePatchRect
@onready var sfx_player: AudioStreamPlayer = $SfxPlayer

var background_margin: int = 4

func _ready() -> void:
	for levels in GameManager.level_paths.size():
		var level = level_button.instantiate()
		level_button_container.add_child(level)
		level.text = "Level " + str(levels + 1)
		level.pressed.connect(func(): 
			GameManager.safe_load_level(levels)
			sfx_player.play()
			)
	
	nine_patch_rect.size = Vector2(level_button_container.size.x + background_margin * 2, level_button_container.size.y + background_margin * 2)
