extends StateMachine

func _ready():
	add_state("idel")
	add_state("search")
	add_state("target")
#	add_state("run")
	call_deferred("set_state", states.search)
	
func _state_logic(delta):
	
	if state == states.search:
		parent.search(delta)
	else:
		parent.move_to_tar(delta)
		
		


func _get_transition(delta):
	match state:
		states.idel:
			if parent.search:
				return states.search
			if not parent.search:
				return states.target
		states.search:
			if not parent.search:
				return states.target
			if parent.idel:
				return states.idel
		states.target:
			if  parent.search:
				return states.search
			if parent.idel:
				return states.idel
#		states.run:
#			pass
			
	return  null


func _enter_state(new_state, old_state):
	match new_state:
		states.idel:
			parent.animation_player.play("_Idle")
		states.search:
			parent.animation_player.play("_Walk")
		states.target:
			parent.animation_player.play("_Walk")
#		states.run:
#			parent.animation_player.play("_Run")
	print(new_state)

func _exit_state(old_state, new_state):
	pass
