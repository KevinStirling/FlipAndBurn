extends RigidBody2D

@onready var helm = $Helm

var thrust = Vector2(10, 0)
var lat_rev_thrust = Vector2(-5,0)
var lat_thrust = Vector2(0, 5)
var torque = 300

#var burn 
#var lateral_reverse
#var lateral_left
#var lateral_right
#var rotate_left
#var rotate_right

# Called when the node enters the scene tree for the first time.
func _ready():
#	work around for torque not being applied to segment based collision shapes
	inertia = 14084.51
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _integrate_forces(state):
	if Input.is_action_pressed("burn"):
		apply_central_impulse(thrust.rotated(transform.get_rotation()))
	if Input.is_action_pressed("lateral_reverse"):
		apply_central_impulse(lat_rev_thrust.rotated(transform.get_rotation()))
	if Input.is_action_pressed("lateral_left"):
		apply_impulse(lat_thrust.rotated(transform.get_rotation()))
	if Input.is_action_pressed("lateral_right"):
		apply_impulse(-lat_thrust.rotated(transform.get_rotation()))
	if Input.is_action_pressed("rotate_left"):
		apply_torque_impulse(torque)
	if Input.is_action_pressed("rotate_right"):
		apply_torque_impulse(-torque)


