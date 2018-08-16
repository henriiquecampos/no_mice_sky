extends Node

var state = null setget set_state, get_state
signal state_changed(previous, current)

func set_state(new_state):
	if new_state == null:
		return
	new_state = get_node(new_state)
	if new_state == state:
		return
	if state != null:
		state.clear()
		emit_signal("state_changed", state, new_state)
	new_state.initialize(get_parent())
	state = new_state
	
func get_state():
	return state