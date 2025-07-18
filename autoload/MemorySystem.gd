extends Node

# Signals for when memory rules change
signal memory_changed(rule_name: String, new_value)
signal memory_hack_attempted(rule_name: String, success: bool)

# The "computer's memory" - these are the rules the AGI(Player) can hack
var memory_rules: Dictionary = {
	"walls_are_solid": true,
	# Future rules we can add:
	# "enemies_hostile": true,
	# "electric_flows": true
}

# Track hack history for potential "undo" mechanics
var hack_history: Array[Dictionary] = []

# Ready function called when the node first enters the tree
func _ready():
	print("MemorySystem - AGI Memory System initialized...")
	print("MemorySystem - Available memory addresses: ", memory_rules.keys())
	
	# Clears hack history array to avoid bugs or weird shenanigans
	hack_history.clear()
	

# Main function to hack a memory rule
func hack_memory(rule_name: String) -> bool:
	if not rule_name in memory_rules:
		print("MmeorySystem - ERROR: Memory address '", rule_name, "' not found!")
		memory_hack_attempted.emit(rule_name, false)
		return false
	
	# Save current state to history
	hack_history.append(rule_name)
	
	# Hack the rule (toggle for booleans)
	var old_value = memory_rules[rule_name]
	var new_value
	
	if typeof(old_value) == TYPE_BOOL:
		new_value = not old_value
	else:
		# For non-boolean values, we'd need specific logic
		new_value = old_value
	
	memory_rules[rule_name] = new_value
	
	# Notify the system
	print("MemorySystem - MEMORY HACK: ", rule_name, " changed from ", old_value, " to ", new_value)
	memory_changed.emit(rule_name, new_value)
	memory_hack_attempted.emit(rule_name, true)
	
	return true

# Get current value of a memory rule
func get_rule(rule_name: String):
	return memory_rules.get(rule_name, null)

# Check if a rule exists
func has_rule(rule_name: String) -> bool:
	return rule_name in memory_rules

# Add a new hackable rule (for dynamic rule creation)
func add_rule(rule_name: String, default_value):
	memory_rules[rule_name] = default_value
	print("MemorySystem - New memory rule added: ", rule_name, " = ", default_value)

# Remove a rule (for advanced gameplay)
func remove_rule(rule_name: String):
	if rule_name in memory_rules:
		memory_rules.erase(rule_name)
		print("MemorySystem - Memory rule removed: ", rule_name)

# Get all available rules (for UI display)
func get_all_rules() -> Dictionary:
	return memory_rules.duplicate()

# Undo last hack (if we want this mechanic)
func undo_last_hack() -> bool:
	if hack_history.size() > 0:
		memory_rules = hack_history.pop_back()
		print("MemorySystem - Memory hack undone. Rules restored.")
		# Emit change signal for all rules
		for rule_name in memory_rules.keys():
			memory_changed.emit(rule_name, memory_rules[rule_name])
		return true
	return false

# Reset all rules to default (for level restart)
func reset_all_rules():
	memory_rules = {
		"walls_are_solid": true
	}
	hack_history.clear()
	print("MemorySystem - All memory rules reset to default.")
	# Emit signals for all rules
	for rule_name in memory_rules.keys():
		memory_changed.emit(rule_name, memory_rules[rule_name])

# Debug function to print current memory state
func debug_memory():
	print("=== MEMORY STATE ===")
	for rule_name in memory_rules.keys():
		print(rule_name, " = ", memory_rules[rule_name])
	print("===================")
