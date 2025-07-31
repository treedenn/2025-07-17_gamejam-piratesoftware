class_name XorGate extends LogicGate

@onready var m_sprite: Sprite2D = $MSprite

func _ready():
	_update_sprite()
		
	super._ready()

func _update_sprite():
	
	if m_receiver1.get_signal() == 1 && m_receiver2.get_signal() == 0:
		m_sprite.frame = 4
		if line_to_gate:
			line_to_gate.modulate = Color.RED
	if m_receiver1.get_signal() == 0 && m_receiver2.get_signal() == 1:
		m_sprite.frame = 5
		if line_to_gate:
			line_to_gate.modulate = Color.RED
	if m_receiver1.get_signal() == 1 && m_receiver2.get_signal() == 1:
		if line_to_gate:
			line_to_gate.modulate = Color.WHITE
		m_sprite.frame = 6

func _update():
	var new_output := m_receiver1.get_signal() ^ m_receiver2.get_signal()
	if reversed:
		new_output = ~(new_output) & 1
		
	m_transmitter.send_signal(new_output)
