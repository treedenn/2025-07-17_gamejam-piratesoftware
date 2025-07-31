class_name AndGate extends LogicGate

@onready var m_sprite: AnimatedSprite2D = $NormalState

func _ready():
	print("Gate: ", name)
	print("Receiver1 ID: ", m_receiver1.get_instance_id())
	print("Receiver2 ID: ", m_receiver2.get_instance_id())
	_update_sprite()
	
	if reversed:
		m_sprite.visible = false
		m_sprite = $NotState
	else:
		$NotState.visible = false
		
	super._ready()

func _update_sprite():
	var frameName := "none"
	if m_receiver1.get_signal() == 1 && m_receiver2.get_signal() == 0:
		if line_to_gate:
			line_to_gate.modulate = Color.WHITE
		frameName = "inputa"
	if m_receiver1.get_signal() == 0 && m_receiver2.get_signal() == 1:
		frameName = "inputb"
		if line_to_gate:
			line_to_gate.modulate = Color.WHITE
	if m_receiver1.get_signal() == 1 && m_receiver2.get_signal() == 1:
		if line_to_gate:
			line_to_gate.modulate = Color.RED
		frameName = "full"
	m_sprite.animation = frameName

func _update():
	var new_output := m_receiver1.get_signal() & m_receiver2.get_signal()
	print(name, " is throwing this output: ", new_output)
	if reversed:
		new_output = ~(new_output) & 1
		
	m_transmitter.send_signal(new_output)
