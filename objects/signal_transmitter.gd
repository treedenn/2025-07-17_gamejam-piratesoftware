class_name SignalTransmitter extends Node

var m_receivers: Array[SignalReceiver]

func _init() -> void:
	m_receivers = []
	

func add_receiver(receiver: SignalReceiver):
	m_receivers.append(receiver)

func delete_receiver(receiver: SignalReceiver):
	for i in range(m_receivers.size()):
		if m_receivers[i] == receiver:
			m_receivers.remove_at(i)

func send_signal(value: int):
	for receiver in m_receivers:
		if(receiver == null): 
			print("Sending signal to outer space!")
		else:
			receiver.set_signal(value)
