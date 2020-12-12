extends StateMachine


func _ready():
	add_state("eated")
	add_state("grow")
	call_deferred("set_state", states.grow)
	
	
func _state_logic(delta):
#	print(state)
	if parent._eaten:
		parent.eated()
	else:
		parent.grow()


func _get_transition(delta):
	match state:
		states.eated:
			if not parent._eaten:
				return states.grow
		states.grow:
			if parent._eaten:
				return states.eated

	return  null


func _enter_state(new_state, old_state):
	match new_state:
		states.grow:
			pass
		states.eated:
			pass


func _exit_state(old_state, new_state):
	pass
	


