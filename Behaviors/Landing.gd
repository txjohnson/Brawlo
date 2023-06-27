extends AbstractBehavior
class_name Landing

@export var landing_lag_time :int = 4
@export var after_land :String = "Idle"

var after_land_node :Node = null

func condition () -> bool:
	if host.velocity.y <= 0:
		return false

	var collider

	if host.GroundL.is_colliding():
		collider = host.GroundL.get_collider()
	elif host.GroundR.is_colliding():
		collider = host.GroundR.get_collider()
	else:
		return false

	am.reset_frame()
	if host.velocity.y > 0:
		host.velocity.y = 0
	
	host.velocity.x = 0
	return true


func tick( delta ) -> Node:
	if am.frame >= landing_lag_time:
		return after_land_node
	return null


func can_transition () -> bool:
	if am.frame >= landing_lag_time:
		return true
	return false

func update_reachables( map ):
	if after_land:
		after_land_node = map [after_land]
		
	super( map )


# Called when the node enters the scene tree for the first time.
func _ready():
	if action == "":
		action = "Landing"

