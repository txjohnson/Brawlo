extends Node
class_name AbstractBehavior

@export var action :String = ""

@export var reachables :PackedStringArray

var reachable_nodes = []


var host :Node = null
var am   :Node = null

var start_frame :int = 0


func condition () -> bool:
	return false


func tick( delta ) -> Node:
	return null


func can_transition () -> bool:
	return true


func transition () -> Node:
	if not can_transition():
		return null

	for n in reachable_nodes:
		if n .condition():
			return n
	return null


func update_reachables( map ):
	reachable_nodes .clear()
	
	for r in reachables:
		var i = map [r]
		assert (i != null, "The action '%s' was not found in ActionManager" % r)
		reachable_nodes .push_back (i)


# Called top down as scene tree is constructed.
func _enter_tree():
	am   = get_parent()
	host = am.host


# Called bottom up as scene tree is constructed.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
