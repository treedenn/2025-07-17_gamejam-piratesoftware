extends Node

@onready var player: Player = get_tree().get_first_node_in_group("Player")

# -- Properties --
var current_level_index: int = 0
var level_paths: Array[String] = [
	"res://rooms/room1.tscn",
	"res://levels/Level_01.tscn",
]

var current_level: PackedScene
var level_node: Node

# -- Load the first level on game start --
func _ready():
	safe_load_level.call_deferred(current_level_index)

# -- Load a level by index --
func load_level(index: int):
	if index < 0 or index >= level_paths.size():
		printerr("Level index out of range.")
		return

func safe_load_level(index: int):
	await get_tree().process_frame
	load_level(index)

	current_level_index = index
	var scene_path = level_paths[index]
	current_level = load(scene_path)

	if not current_level:
		printerr("Failed to load scene: ", scene_path)
		return

	get_tree().change_scene_to_packed(current_level)

# -- Restart current level --
func restart_level():
	load_level(current_level_index)

# -- Load the next level --
func load_next_level():
	var next_index = current_level_index + 1
	if next_index >= level_paths.size():
		# Optionally: show credits, return to menu, etc.
		print("All levels complete!")
		get_tree().change_scene_to_file("res://main/Main.tscn")
	else:
		load_level(next_index)

# -- Go back to main menu --
func return_to_menu():
	get_tree().change_scene_to_file("res://main/Main.tscn")
