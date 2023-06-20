extends StateMachine

func _ready():	
	add_state('STAND')
	add_state('JUMP_SQUAT')
	add_state('SHORT_HOP')
	add_state('FULL_HOP')
	add_state('DASH')
	add_state('MOONWALK')
	add_state('WALK')
	add_state('CROUCH')
	call_deferred( "set_state", states.STAND)

func exit_state( new_state, old_state ):
	pass
	
func enter_state( old_state, new_state ):
	pass
	
	
func state_logic( delta ):
	pass

func get_transition( delta ):
	match state:
		states.STAND:
			pass
		states.JUMP_SQUAT:
			pass
		states.SHORT_HOP:
			pass
		states.FULL_HOP:
			pass
		states.DASH:
			pass
		states.MOONWALK:
			pass
		states.WALK:
			pass
		states.CROUCH:
			pass
	pass

