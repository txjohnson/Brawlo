extends Node
class_name ActionsManager


var agent :Node = null
var PID   :int

var running :Node = null

@export var blackboard:Node


var frame :int   = 0
var am    :Node   = self
var host  :Node

func reset_frame ():
	frame = 0

func _physics_process(delta):
	frame += 1
	host.Frame.text = str(frame)
	
	host .move_and_slide()
	var next = running .tick( delta )

	if next == null:
		var n = running .transition()
		if n != null:
			reset_frame()
			running = n
	else:
		reset_frame()
		running = next
		
	host.Action.text = running.action


# Let children know the ids of all the nodes the manager knows about
func update_reachables ():
	var num_children = get_child_count()
	var action_map = {}

	# first, get the action names of all of the children
	for i in num_children:
		var child = get_child(i)
		action_map [child.action] = child

	# hand that to each child and let the do their update
	for i in num_children:
		var node = get_child(i)
		node .update_reachables( action_map )


func _enter_tree():
	host = get_parent ()
	PID = host.player_num



# Called when the node enters the scene tree for the first time.
func _ready():
	assert(get_child_count() > 0, "ActionManager cannot work without at least 1 behavior.")
	running = get_child(0)
	update_reachables()



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
