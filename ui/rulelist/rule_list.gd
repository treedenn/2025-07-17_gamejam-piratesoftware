extends PanelContainer


@export var rule_scene: PackedScene

@onready var rule_container: VBoxContainer = $ListAndButtonContainer/RuleContainer
@onready var show_hide_button: Button = $ListAndButtonContainer/ShowHideButton

var _rule_list: Array = []
var is_open: bool = false

func _ready() -> void:
	# Clears the array initially
	_rule_list.clear()
	
	# Connects to relevant signals
	connect_signals()
	
	# Sets the rule container visibility to false to begin with (less clutter)
	rule_container.visible = false
	
	print("RuleList - Is it connected? ", MemorySystem.memory_changed.is_connected(_add_rule))
	
	# TESTING PURPOSES ONLY
	# TODO: REMOVE AFTER TESTING
	MemorySystem.hack_memory("walls_are_solid")
	MemorySystem.hack_memory("walls_are_solid")
	MemorySystem.hack_memory("walls_are_solid")

# Hides the rulelist if it's open, shows it if it isn't
func show_or_hide_rulelist():
	if is_open:
		rule_container.visible = false
		is_open = false
		show_hide_button.text = "Show"
	else:
		rule_container.visible = true
		is_open = true
		show_hide_button.text = "Hide"

# Function is called when memory_changed is emitted and adds the rules to the list and updates it
func _add_rule(rule_name: String, value: bool):
	var rule: Dictionary = {rule_name: value}
	_rule_list.append(rule)
	
	update_list()
	print("RuleList - Rule Added")

# Updates the list by clearing it first then readding the children
func update_list():
	var rule_children = rule_container.get_children()
	
	# Removes all the children
	for child in rule_children:
		child.queue_free()
		remove_child(child)
	
	# Ressurrects the necessary children
	for rules in _rule_list:
		var rule = rule_scene.instantiate()
		rule_container.add_child(rule)
		rule.rule_name.text = rules.keys()[0]
		rule.value.text = str(rules.values()[0])

func connect_signals():
	MemorySystem.memory_changed.connect(_add_rule)
	show_hide_button.pressed.connect(show_or_hide_rulelist)
		
		
	
