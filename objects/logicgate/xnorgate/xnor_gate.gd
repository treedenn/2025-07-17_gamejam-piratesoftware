class_name XnorGate extends LogicGate

@onready var m_sprite: AnimatedSprite2D = $NormalState

func _ready():
	if reversed:
		m_sprite.visible = false
		m_sprite = $NotState
	else:
		$NotState.visible = false
		
	super._ready()

func _update_sprite():
	var frameName := "none"
	if m_receiver1.get_signal() == 1 && m_receiver2.get_signal() == 0:
		frameName = "inputa"
	elif m_receiver1.get_signal() == 0 && m_receiver2.get_signal() == 1:
		frameName = "inputb"
	elif m_receiver1.get_signal() == 1 && m_receiver2.get_signal() == 1:
		frameName = "full"
	m_sprite.animation = frameName

func _update():
	var xor_output := m_receiver1.get_signal() ^ m_receiver2.get_signal()
	var new_output := ~xor_output & 1
	if reversed:
		new_output = 1 - new_output
		
	m_transmitter.send_signal(new_output)
