extends StateMachine


func _ready():
	add_state("idel")
	add_state("walk")
	add_state("jump")
	add_state("interact")
	call_deferred("set_state", states.idel)
	
	
	
func _state_logic(delta):
	pass

func _get_transition(delta):
#	match state:
#		states.idel:
#			if parent._can_walk:
#				return states.walk
#			elif parent._can_jump:
#				return states.jump
#		states.walk:
#			if not parent._can_walk:
#				return states.idel
#			elif parent._can_jump:
#				return states.jump
#		states.jump:
#			if parent._can_walk:
#				return states.walk
#			else:
#				return states.idel
				
	return  null
	
func _enter_state(new_state, old_state):
	match new_state:
		states.idel:
			pass
		states.walk:
			pass
		states.jump:
			pass

func _exit_state(old_state, new_state):
	pass
	

