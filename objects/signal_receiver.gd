class_name SignalReceiver extends Node

var m_signal := 0

signal signal_changed(new_signal: int)

func set_signal(value: int):
	if m_signal != value:
		m_signal = value
		signal_changed.emit(m_signal)
		
func get_signal() -> int:
	return m_signal
