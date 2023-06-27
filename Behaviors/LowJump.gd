extends AbstractBehavior
class_name LowJump

@export var after_jump :String
@export var low_jump_force :float = 900.0

var after_jump_node :Node = null




func condition () -> bool:
	return true


func tick( delta ) -> Node:
	host.velocity.y = -low_jump_force
	return after_jump_node


func update_reachables( map ):
	if after_jump:
		after_jump_node = map [after_jump]
		
	super( map )


func _ready():
	if action == "":
		action = "LowJump"
