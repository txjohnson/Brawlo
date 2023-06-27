extends AbstractBehavior
class_name Idle




func condition () -> bool:
	if host.velocity.x == 0.0:
		return true

	return false







func _ready():
	if action == "":
		action = "Idle"
