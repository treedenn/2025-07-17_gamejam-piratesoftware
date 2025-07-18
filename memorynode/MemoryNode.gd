extends Node
class_name MemoryNode

signal node_activated(memory_node: MemoryNode)
signal hack_completed(rule_name: String, new_value)

@export var tile_size: int = 16
@export var memory_rule: String = "walls_are_solid"  # Which rule this node hacks
@export var hack_description: String = "Toggle wall collision"
@export var one_time_use: bool = false  # Can only be used once
@export var requires_standing: bool = true  # Must be standing on it vs just touching

#TODO: the rest lmao
