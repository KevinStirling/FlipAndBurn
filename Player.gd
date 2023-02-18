extends PlayerState

@onready var ship_interior = get_node("/root/Space/Ship/ShipFloor")
@onready var ship = get_node("/root/Space/Ship")
@onready var space = get_node("/root/Space")
@onready var helm = get_node("/root/Space/Ship/Helm")
@onready var ext_cam = get_node("/root/Space/Ship/ExternalCamera")

@export var DEF_CAM_ZOOM = Vector2(2,2)

var on_floor = true
var in_helm_trigger = false
var in_helm = false


func _ready():
	state_factory = StateFactory.new()
	change_state("idle")
	ship_interior.body_entered.connect(_player_entered_ship)
	ship_interior.body_exited.connect(_player_exited_ship)
	helm.body_entered.connect(_helm_entered)
	helm.body_exited.connect(_helm_exited)

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

func _helm_entered(_body):
	print("helm trigger entered")
	in_helm_trigger = true

func _helm_exited(_body):
	print("helm trigger exited")
#	work around for area_entered emitting when ship moving fast
	if !in_helm:
		in_helm_trigger = false

func _unhandled_input(_event):
	if Input.is_action_just_pressed("interact"):
		if in_helm_trigger:
			if in_helm :
				print("no longer helming ship")
				in_helm = false
				ship.player_in_helm = false
				ext_cam.enabled = false
				$Camera.enabled = true
			elif !in_helm:
				print("now helming ship")
				in_helm = true
				ship.player_in_helm = true
				$Camera.enabled = false
				ext_cam.enabled = true

func _physics_process(_delta):
	if Input.is_action_pressed("sprint"):
		change_state("run")
	if Input.is_action_just_released("sprint"):
		change_state("walk")
	if !in_helm :
		var input_direction = Input.get_vector("left", "right", "up", "down")
		if on_floor :
			velocity = input_direction.normalized().rotated(ship.transform.get_rotation())
			state.move(velocity)
		if input_direction != Vector2.ZERO:
			$BodySprite.rotation = lerp_angle(deg_to_rad($BodySprite.rotation_degrees), input_direction.angle(), .2)
