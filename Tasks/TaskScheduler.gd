extends Node
class_name TaskScheduler

var agent :Node = null
var PID   :int

var frame :int    = 0
var actor :Node   = self


func _physics_process(delta):
	var all_idle :bool = true

	frame += 1

	var num_children = get_child_count ()
	
	for i in num_children:
		var task = get_child( i )
		
		if task.state == AbstractTask.TaskState.IDLE:
			task.activate( delta )
			
		task .do_task( delta )

		if task.state == AbstractTask.TaskState.RUNNING:
			all_idle = false

	if all_idle:
		frame = 0



func _get_configuration_warning() -> String:
	if get_child_count() > 0:
		for i in get_child_count():
			if not get_child(i) is AbstractTask:
				return "Only tasks can be a child of this node"

		return "Node needs at a behavior"

	return ""

func _enter_tree():
	actor = get_parent ()
	PID = actor.player_num
