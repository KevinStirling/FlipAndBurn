extends CharacterBody2D

@onready var ship_interior = $"../Ship/ShipFloor"
@onready var ship = $"../Ship"
@onready var raycast = $RayCast2D

const SPEED = 300.0
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
	velocity = Vector2.ZERO
	var position_from_wall = position.distance_to(raycast.get_collision_point())
	
	var input_direction = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	velocity = input_direction.normalized() * SPEED
	if on_floor : 
		velocity = velocity + ship.linear_velocity
		rotation = ship.transform.get_rotation()
#		use position_from_wall to simulate the player standing on a rotating platform??
		
	move_and_slide()
	

