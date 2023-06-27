extends AbstractBehavior
class_name Dash

@export var dash_wait   :int = 2
@export var dash_time   :int = 8
@export var dash_speed  :float = 800
@export var after_dash  :String = ""

@onready var LEFT :String  = "left_%s"  % am.PID
@onready var RIGHT :String = "right_%s" % am.PID

var after_dash_node :Node = null

func condition () -> bool:
	if am.frame < dash_wait:
		return false

	if Input.is_action_just_pressed(RIGHT):
		print("right dash: ", host.velocity)
		host.velocity.x = dash_speed
		host.turn( false )
		return true

	elif Input.is_action_just_pressed(LEFT):
		print("left dash: ", host.velocity)
		host.velocity.x = -dash_speed
		host.turn( true )
		return true


	return false

func tick( delta ) -> Node:
	if am.frame >= dash_time:
		host.velocity.x = 0.0
		return after_dash_node
	return null



func update_reachables( map ):
	if after_dash:
		after_dash_node = map [after_dash]
		
	super( map )




func _ready():
	if action == "":
		action = "Dash"

