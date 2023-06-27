extends AbstractBehavior
class_name Crouch

@export var move_speed :int = 400
@export var traction :float = 40

@export var after_crouch :String = "Idle"

@onready var DOWN :String  = "down_%s"  % am.PID

var after_crouch_node :Node = null

func condition () -> bool:
	if Input.is_action_pressed(DOWN):
		return true
	return false


func tick( delta ) -> Node:
	if Input.is_action_just_released( DOWN ):
		return after_crouch_node

	if host.velocity.x > 0:
		if host.velocity.x > move_speed:
			host.velocity.x += -(traction * 4)
			host.velocity.x = clamp( host.velocity.x, 0, host.velocity.x )
		else:
			host.velocity.x += -(traction / 2)
			host.velocity.x = clamp( host.velocity.x, 0, host.velocity.x )
		
	elif host.velocity.x < 0:
		if abs(host.velocity.x) > move_speed:
			host.velocity.x += traction * 4
			host.velocity.x = clamp( host.velocity.x, host.velocity.x, 0 )
		else:
			host.velocity.x += traction / 2
			host.velo
			host.velocity.x = clamp( host.velocity.x, host.velocity.x, 0 )

	return null


func update_reachables( map ):
	if after_crouch:
		after_crouch_node = map [after_crouch]
		
	super( map )


# Called when the node enters the scene tree for the first time.
func _ready():
	if action == "":
		action = "Crouch"

