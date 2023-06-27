extends AbstractBehavior
class_name AbstractCondition


@onready var CHILD = get_child(0)

var running :bool = false


func _get_configuration_warning() -> String:
	if get_child_count() == 1:
		return "Node needs at a behavior"

	if not get_child(0) is AbstractBehavior:
		return "One of the child nodes is not a behavior"

	return ""


func check() -> bool:
	return false


func tick (delta) -> RunState:
	var cr = check()
	var state :RunState
	
	if running:
		if cr:
			CHILD.stop()
			
		state = CHILD.tick(delta)
		if state != RunState.RUNNING:
			running = false
			return state

	if not cr:
		return RunState.FAILURE
		
	state = CHILD.tick(delta)
	if state == RunState.RUNNING:
		running = true
		
	return state



# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
