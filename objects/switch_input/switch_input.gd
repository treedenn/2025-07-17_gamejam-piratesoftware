extends LogicGate
class_name ButtonSwitch

@onready var switch_sprite: Sprite2D = $SwitchSprite
@export var line_to_gate: Line2D

var player: Player

var player_in_range: bool = false
	
func _ready() -> void:
	match _output:
		0:
			switch_sprite.frame = 3
		1:
			switch_sprite.frame = 4
			
	await get_tree().process_frame
	player = GameManager.player

func _unhandled_input(event: InputEvent) -> void:
	if player_in_range:
		if Input.is_action_just_pressed("interact"):
			if player._current_state == 0 and _output != 0:
				print(_output, " | ", player._current_state, "output and playerstate")
				_output = 0
				player.change_state(player.State.One)
				output_changed.emit(_output)
				switch_sprite.frame = 3
				if line_to_gate:
					line_to_gate.modulate = Color.WHITE
				return
				
			if player._current_state == 1 and _output != 1:
				print(_output, " | ", player._current_state, "output and playerstate")
				_output = 1
				player.change_state(player.State.Zero)
				switch_sprite.frame = 4
				output_changed.emit(_output)
				if line_to_gate:
					line_to_gate.modulate = Color.RED
				return

func _on_player_check_area_entered(area: Area2D) -> void:
	if area.get_parent() is Player:
		print("Player Entered Switch")
		player_in_range = true

func _on_player_check_area_exited(area: Area2D) -> void:
	if area.get_parent() is Player:
		print("Player Exited Switch")
		player_in_range = false
