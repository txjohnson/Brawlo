extends AbstractBehavior
class_name HighJump

@export var after_jump :String
@export var high_jump_force :float = 1200.0

@onready var JUMP :String  = "jump_%s"  % am.PID

var after_jump_node :Node = null

func condition () -> bool:
	if Input.is_action_pressed(JUMP):
		return true
	return false


func tick( delta ) -> Node:
	host.velocity.y = -high_jump_force
	return after_jump_node


func update_reachables( map ):
	if after_jump:
		after_jump_node = map [after_jump]
		
	super( map )


func _ready():
	if action == "":
		action = "HighJump"

