extends Node
class_name StateMachine

var state = null : set = set_state
var previous_state = null
var states = {}

@onready var parent = get_parent()

func _physics_process(delta):
	if state != null:
		state_logic( delta )
		var transition = get_transition( delta )
		if transition != null:
			set_state( transition )

func set_state( new_state ):
	if state != null:
		exit_state( state, new_state )

	previous_state = state
	state = new_state
	
	if new_state != null:
		print("changing to state ", find_key_for_value (new_state))
		enter_state( previous_state, new_state )

	
func state_logic( delta ):
	parent .update_frames( delta )
	parent ._physics_process( delta )
	pass

func get_transition( delta ):
	pass

func add_state( astate ):
	states[astate] = states.size()

func exit_state( new_state, old_state ):
	pass
	
func enter_state( old_state, new_state ):
	pass

func find_key_for_value (v):
	var vals = states.values()
	var keys = states.keys()
	
	for i in vals.size():
		if vals[i] == v:
			return  keys[i]
	
	
#func state_includes(state_array) -> bool:
#	return false
#	pass
