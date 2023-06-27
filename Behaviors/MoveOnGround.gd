extends AbstractBehavior
class_name MoveOnGround

@export var move_speed :int = 400
@export var traction :float = 40

@onready var LEFT :String  = "left_%s"  % am.PID
@onready var RIGHT :String = "right_%s" % am.PID


func condition () -> bool:
	if Input.get_action_strength(RIGHT) == 1:
		host.velocity.x = move_speed
		host.turn( false )
		return true

	if Input.get_action_strength(LEFT) == 1:
		host.velocity.x = -move_speed
		host.turn( true )
		return true
		
	return false


func tick( delta ) -> Node:
	if Input.get_action_strength(RIGHT) == 1:
		if host.velocity.x < 0:  # reset to make dash wait again
			am.reset_frame()
		host.velocity.x = move_speed
		host.turn( false )

	if Input.get_action_strength(LEFT) == 1:
		if host.velocity.x > 0:  # reset to make dash wait again
			am.reset_frame()
		host.velocity.x = -move_speed
		host.turn( true )

	if host.velocity.x < 0:
		host.velocity.x += traction * 1
		host.velocity.x = clamp(host.velocity.x, host.velocity.x, 0.0)
	elif host.velocity.x > 0:
		host.velocity.x += -traction * 1
		host.velocity.x = clamp(host.velocity.x, 0.0, host.velocity.x)

	return null


func _ready():
	if action == "":
		action = "MoveOnGround"

	print(LEFT)
	print(RIGHT)
