extends StateMachine

@export var id = 1


var left = "left_%s" % id
var right = "right_%s" % id
var down = "down_%s" %id
var jump = "jump_%s" % id

func _ready():	
	add_state('STAND')
	add_state('JUMP_SQUAT')
	add_state('SHORT_HOP')
	add_state('FULL_HOP')
	add_state('DASH')
	add_state('WALK')
	add_state('CROUCH')
	add_state('AIR')
	add_state('RUN')
	add_state('LANDING')
	call_deferred( "set_state", states.STAND)

func exit_state( new_state, old_state ):
	pass
	
func enter_state( old_state, new_state ):
	parent.StateName.text = find_key_for_value(new_state)
	
	match new_state:
		states.STAND:
			parent.play_animation('Idle')
		states.DASH:
			parent.play_animation('Run')
		states.JUMP_SQUAT:
			parent.play_animation('Squat')
		states.SHORT_HOP:
			parent.play_animation('JumpUp')
		states.FULL_HOP:
			parent.play_animation('JumpUp')
		states.AIR:
			parent.play_animation('JumpDown')
		states.LANDING:
			parent.play_animation('Squat')
	pass
	
func state_includes(state_array) -> bool:
	for s in state_array:
		if state == s:
			return true
	return false


func state_logic( delta ):
	parent .update_frame( delta )
	parent ._physics_process( delta )
	pass

func get_transition( delta ):
	parent .move_and_slide()
	
	if landing() == true:
		parent.reset_frame()
		return states.LANDING
		
	if falling() == true:
		return states.AIR
		
	match state:
		states.STAND:
			if Input.is_action_pressed(jump):
				parent.reset_frame()
				return states.JUMP_SQUAT

			if Input.get_action_strength(right) == 1:
				parent.velocity.x = parent.RUNSPEED
				parent.reset_frame()
				parent.turn(false)
				return states.DASH
				
			if Input.get_action_strength(left) == 1:
				parent.velocity.x = -parent.RUNSPEED
				parent.reset_frame()
				parent.turn(true)
				return states.DASH
				
			if parent.velocity.x > 0 and state == states.STAND:
				parent.velocity.x += -parent.TRACTION * 1
				parent.velocity.x = clamp(parent.velocity.x, 0.0, parent.velocity.x)
			elif parent.velocity.x < 0 and state == states.STAND:
				parent.velocity.x += parent.TRACTION * 1
				parent.velocity.x = clamp(parent.velocity.x, parent.velocity.x, 0.0)

		states.JUMP_SQUAT:
			if parent.frame == parent.SQUATTIME:
				if not Input.is_action_pressed(jump):
					parent.velocity.x = lerp(parent.velocity.x, 0.0, 0.08)
					parent.reset_frame()
					return states.SHORT_HOP
				else:
					parent.velocity.x = lerp(parent.velocity.x, 0.0, 0.08)
					parent.reset_frame()
					return states.FULL_HOP

		states.SHORT_HOP:
			parent.velocity.y = -parent.JUMPFORCE
			parent.reset_frame()
			print("now in air from short_hop")
			return states.AIR

		states.FULL_HOP:
			parent.velocity.y = -parent.MAX_JUMPFORCE
			parent.reset_frame()
			print("now in air from full_hop")
			return states.AIR

		states.DASH:
			if Input.is_action_pressed(left):
				if parent.velocity.x > 0:
					parent.reset_frame()
				parent.velocity.x = -parent.DASHSPEED
			elif Input.is_action_pressed(right):
				if parent.velocity.x < 0:
					parent.reset_frame()
				parent.velocity.x = parent.DASHSPEED
			else:
				if parent.frame >= parent.DASHTIME - 1:
					print('finished dashing')
					return states.STAND

		states.WALK:
			pass
		states.RUN:
			pass
		states.CROUCH:
			pass
		states.AIR:
			air_movement()
			
		states.LANDING:
			if parent.frame <= parent.landing_frame + parent.lag_frame:
				if parent.frame == 1:
					return
				if parent.velocity.x > 0:
					parent.velocity.x = parent.velocity.x - parent.TRACTION / 2
					parent.velocity.x = clamp(parent.velocity.x, 0.0, parent.velocity.x)
				elif parent.velocity.x < 0:
					parent.velocity.x = parent.velocity.x + parent.TRACTION / 2
					parent.velocity.x = clamp(parent.velocity.x, parent.velocity.x, 0.0)
				
				if Input.is_action_pressed(jump):
					parent.reset_frame()
					return states.JUMP_SQUAT
			else:
				if Input.is_action_pressed(down):
					parent.lag_frame = 0
					parent.reset_frame()
					parent.states.CROUCH
				else:
					print("finished landing")
					parent.reset_frame()
					parent.lag_frame = 0
					return states.STAND
				parent.lag_frame = 0

func air_movement():
	if parent.velocity.y < parent.MAX_FALLSPEED:
		parent.velocity.y += parent.FALLSPEED
	
	if Input.is_action_pressed(down) and parent.down_buffer == 1 and parent.velocity.y > -150 and not parent.fastfall:
		parent.velocity.y = parent.MAX_FALLSPEED
		parent.fastfall = true
	
	if parent.fastfall == true:
#		parent.set_collision.mask_bit(2, false)
		parent.velocity.y = parent.MAX_FALLSPEED
		
	if abs(parent.velocity.x) >= abs(parent.MAX_FALLSPEED):
		if parent.velocity.x > 0:
			if Input.is_action_pressed(left):
				parent.velocity.x += -parent.AIR_ACCEL
			elif Input.is_action_pressed(right):
				parent.velocity.x = parent.velocity.x
		if parent.velocity.x < 0:
			if Input.is_action_pressed(left):
				parent.velocity.x = parent.velocity.x
			elif Input.is_action_pressed(right):
				parent.velocity.x += parent.AIR_ACCEL

	elif abs(parent.velocity.x) < abs(parent.MAX_FALLSPEED):
		if Input.is_action_pressed(left):
			parent.velocity.x += -parent.AIR_ACCEL
		if Input.is_action_pressed(right):
			parent.velocity.x += parent.AIR_ACCEL
			
	if not Input.is_action_pressed(left) and not Input.is_action_pressed(right):
		if parent.velocity.x < 0:
			parent.velocity.x += parent.AIR_ACCEL / 5
		elif parent.velocity.x > 0:
			parent.velocity.x += -parent.AIR_ACCEL / 5

func landing():
	if state_includes([states.AIR]):
		print("checking landing while in air")
		print (parent.GroundL.is_colliding(), " and ", parent.GroundR.is_colliding())
		
		if parent.GroundL.is_colliding() and parent.velocity.y > 0:
			var collider = parent.GroundL.get_collider()
			parent.frame = 0
			if parent.velocity.y > 0:
				parent.velocity.y = 0
			parent.fastfall = false
			return true
			
		elif parent.GroundR.is_colliding() and parent.velocity.y > 0:
			var collider2 = parent.GroundR.get_collider()
			parent.frame = 0
			if parent.velocity.y > 0:
				parent.velocity.y = 0
			parent.fastfall = false
			return true

func falling():
	if state_includes([states.RUN, states.WALK, states.STAND, states.CROUCH, states.DASH, states.LANDING, states.JUMP_SQUAT]):
		if not parent.GroundL.is_colliding() and not parent.GroundR.is_colliding():
			print("is falling")
			return true
