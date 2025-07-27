class_name SignalTransmitter extends Node

var m_receiver: SignalReceiver

func set_receiver(receiver: SignalReceiver):
	m_receiver = receiver

func send_signal(value: int):
	if m_receiver:
		m_receiver.set_signal(value)
	else:
		print("Sending signal to outer space!")
