extends CharacterBody2D

@onready var ship_interior = $"../Ship/ShipFloor"
@onready var ship = $"../Ship"

const SPEED = 300.0


# Store the current movement input
var movement = Vector2.ZERO

var on_floor = true


func _ready():
	ship_interior.body_entered.connect(_player_entered_ship)
	ship_interior.body_exited.connect(_player_exited_ship)
	
func _player_entered_ship(body):
	on_floor = true
	print("player inside")
	
func _player_exited_ship(body):
	on_floor = false
	print("player outside")

 

func _physics_process(delta):
# THIS OBVIOUSLY NEEDS TO BE CHANGED
	# Get the current velocity

	velocity = Vector2.ZERO
	
	if Input.is_action_pressed('ui_right'):
		velocity.x += 1
	if Input.is_action_pressed('ui_left'):
		velocity.x -= 1
	if Input.is_action_pressed('ui_down'):
		velocity.y += 1
	if Input.is_action_pressed('ui_up'):
		velocity.y -= 1
	# Make sure diagonal movement isn't faster
	velocity = velocity.normalized() * SPEED
	#keeps player model locked to the rotation and movement of the ship when inside
	if on_floor : 
		velocity = velocity + ship.linear_velocity
		rotation = ship.rotation
	move_and_slide()
	

