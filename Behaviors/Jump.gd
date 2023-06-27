extends AbstractBehavior
class_name Jump

@export var squat_time :int = 4
@onready var JUMP :String  = "jump_%s"  % am.PID


func condition () -> bool:
	if Input.is_action_pressed(JUMP):
		return true
	return false

func tick( delta ) -> Node:
	host.velocity.x = lerp(host.velocity.x, 0.0, 0.08)
	return null

func can_transition () -> bool:
	if am.frame >= squat_time:
		return true
	return false


# Called when the node enters the scene tree for the first time.
func _ready():
	if action == "":
		action = "Jump"

