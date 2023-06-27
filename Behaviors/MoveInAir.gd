extends AbstractBehavior
class_name MoveInAir

@export var fall_acceleration :float = 50
@export var air_acceleration :float  = 100

@export var max_air_speed    :float = 500
@export var max_fall_speed   :float = 800

@onready var LEFT :String  = "left_%s"  % am.PID
@onready var RIGHT :String = "right_%s" % am.PID
@onready var DOWN :String  = "down_%s"  % am.PID


func condition () -> bool:
	var abs_air_spd = abs(host.velocity.x)
	
	if Input.get_action_strength(RIGHT) == 1 and host.velocity.x < max_air_speed:
		host.velocity.x = min( host.velocity.x + air_acceleration, max_air_speed )
		host.turn( false )
		return true

	if Input.get_action_strength(LEFT) == 1 and host.velocity.x > -max_air_speed:
		host.velocity.x = max( host.velocity.x - air_acceleration, -max_air_speed )
		host.turn( true )
		return true

	return false


func tick( delta ) -> Node:
	if Input.is_action_pressed(DOWN) and  host.velocity.y < max_fall_speed:
		host.velocity.y = max_fall_speed

	if Input.get_action_strength(RIGHT) == 1:
		if host.velocity.x < 0:  # reset to make dash wait again
			am.reset_frame()
		host.velocity.x = min( host.velocity.x + air_acceleration, max_air_speed )
		host.turn( false )

	if Input.get_action_strength(LEFT) == 1:
		if host.velocity.x > 0:  # reset to make dash wait again
			am.reset_frame()
		host.velocity.x = max( host.velocity.x - air_acceleration, -max_air_speed )
		host.turn( true )

	if host.velocity.y < max_fall_speed:
		host.velocity.y += fall_acceleration

	return null


func _ready():
	if action == "":
		action = "MoveInAir"
