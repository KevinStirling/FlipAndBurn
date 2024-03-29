extends PlayerState

@onready var ship_interior = get_node("/root/Space/Ship/ShipFloor")
@onready var ship = get_node("/root/Space/Ship")
@onready var space = get_node("/root/Space")
@onready var helm = get_node("/root/Space/Ship/Helm")
@onready var ext_cam = get_node("/root/Space/Ship/ExternalCamera")

@export var DEF_CAM_ZOOM = Vector2(2,2)

var on_floor = true

func _ready():
	state_factory = StateFactory.new()
	change_state("idle")
	ship_interior.body_entered.connect(_player_entered_ship)
	ship_interior.body_exited.connect(_player_exited_ship)
	var dir = DirAccess

func _player_entered_ship(_body):
	if on_floor != true:
		reparent(ship, true)
		on_floor = true
	print("player inside")
	$Camera.zoom = DEF_CAM_ZOOM
	ship_interior.monitoring = true

func _player_exited_ship(_body):
	if on_floor != false:
		var pos = global_transform
		reparent(space, true)
		transform = pos
		on_floor = false
	print("player outside")
	$Camera.zoom = Vector2(1,1)
	ship_interior.monitoring = true

func _unhandled_input(_event):
	if Input.is_action_just_pressed("interact"):
		if state.interactable != null:
			state.interact(state.interactable)

func _physics_process(_delta):
#	This all needs to be moved to the State's physics process class
	if state.change_state.name != "interacting":
		if Input.is_action_pressed("sprint"):
			change_state("run")
		if Input.is_action_just_released("sprint"):
			change_state("walk")
		var input_direction = Input.get_vector("left", "right", "up", "down")
		if on_floor :
			velocity = input_direction.normalized().rotated(ship.transform.get_rotation())
			state.move(velocity)
		if input_direction != Vector2.ZERO:
			$BodySprite.rotation = lerp_angle(deg_to_rad($BodySprite.rotation_degrees), input_direction.angle(), .2)
