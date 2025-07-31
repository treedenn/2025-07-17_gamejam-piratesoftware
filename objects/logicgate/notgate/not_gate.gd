extends LogicGate
class_name NotGate

@onready var m_sprite: Sprite2D = $MSprite

func _ready():
	_update_sprite()
		
	super._ready()

func _update_sprite():
	
	if m_receiver1.get_signal() == 0:
		m_sprite.frame = 7
		if line_to_gate:
			line_to_gate.modulate = Color.RED
		
	if m_receiver1.get_signal() == 1:
		m_sprite.frame = 1
		if line_to_gate:
			line_to_gate.modulate = Color.WHITE

func _update():
	var new_output
	if m_receiver1.get_signal() == 0:
		new_output = 1
	if m_receiver1.get_signal() == 1:
		new_output = 0
		
	m_transmitter.send_signal(new_output)
