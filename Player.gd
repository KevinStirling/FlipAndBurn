extends CharacterBody2D

@onready var ship_interior = $"../Ship/ShipFloor"

const SPEED = 300.0


# Store the current movement input
var movement = Vector2.ZERO

# Get the gravity from the project settings to be synced with RigidBody nodes.
#var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var gravity = 9.8

func _ready():
	ship_interior.body_entered.connect(_player_entered_ship)
	ship_interior.body_exited.connect(_player_exited_ship)
	
func _player_entered_ship(body):
	print("player inside")
	
func _player_exited_ship(body):
	print("player outside")

 

func _physics_process(delta):
# THIS OBVIOUSLY NEEDS TO BE CHANGED
	# Get the current velocity
	var velocity = Vector2()

# Check if the left or right arrow key is pressed
	if Input.is_action_pressed("ui_right"):
		velocity.x += 1
	if Input.is_action_pressed("ui_left"):
		velocity.x -= 1

	# Check if the up or down arrow key is pressed
	if Input.is_action_pressed("ui_down"):
		velocity.y += 1
	if Input.is_action_pressed("ui_up"):
		velocity.y -= 1

	# Normalize the velocity so that diagonal movement is not faster
	velocity = velocity.normalized()

	# Scale the velocity by the speed
	velocity *= SPEED

	# Apply the velocity to the character's position
#	position += velocity * delta
	move_and_slide()

