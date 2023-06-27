@tool
extends Node
class_name AbstractTask

enum TaskState { IDLE, RUNNING }


var state :TaskState = TaskState.IDLE

var actor :Node = null


# override this
func tick( delta ) -> void:
	pass

# override this
func activate( delta ) -> void:
	pass



# leave this alone (mostly)
func do_task( delta ) -> void:
	var all_idle :bool = true
	
	var num_children = get_child_count ()
	
	for i in num_children:
		var t = get_child (i)
		t .do_task( delta )
		if t.state == TaskState.RUNNING:
			all_idle = false
	
	if not all_idle:
		state = TaskState.RUNNING
		return

	tick( delta )
	if state == TaskState.RUNNING:
		for i in num_children:
			var t = get_child( i )
			t.activate( delta )


	


func _get_configuration_warning() -> String:
	if get_child_count() > 0:
		for i in get_child_count():
			if not get_child(i) is AbstractTask:
				return "Only tasks can be a child of this node"

		return "Node needs at a behavior"

	return ""

# Called top down as scene tree is constructed.
func _enter_tree():
	actor = get_parent().actor


func _ready():
	pass # Replace with function body.
