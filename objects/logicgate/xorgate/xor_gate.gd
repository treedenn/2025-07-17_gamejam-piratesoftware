class_name XorGate extends LogicGate

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
	if m_receiver1.get_signal() == 0 && m_receiver2.get_signal() == 1:
		frameName = "inputb"
	if m_receiver1.get_signal() == 1 && m_receiver2.get_signal() == 1:
		frameName = "full"
	m_sprite.animation = frameName

func _update():
	var new_output := m_receiver1.get_signal() ^ m_receiver2.get_signal()
	if reversed:
		new_output = ~(new_output) & 1
		
	m_transmitter.send_signal(new_output)
