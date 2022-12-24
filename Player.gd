extends CharacterBody2D

@onready var ship_interior = get_node("/root/Space/Ship/ShipFloor")
@onready var ship = get_node("/root/Space/Ship")
@onready var space = get_node("/root/Space")
@onready var helm = get_node("/root/Space/Ship/Helm")
@onready var ext_cam = get_node("/root/Space/Ship/ExternalCamera")

const SPEED = 300.0
const DEF_CAM_ZOOM = Vector2(3,3)

var on_floor = true
var in_helm = false

func _ready():
	ship_interior.body_entered.connect(_player_entered_ship)
	ship_interior.body_exited.connect(_player_exited_ship)
	helm.body_entered.connect(_helm_entered)
	helm.body_exited.connect(_helm_exited)

func _player_entered_ship(body):
	if on_floor != true:
#		var pos = global_position
		var pos = global_transform
		reparent(body, ship)
		transform = pos
		on_floor = true
	print("player inside")
	$Camera.zoom = DEF_CAM_ZOOM
	ship_interior.monitoring = true

func _player_exited_ship(body):
	if on_floor != false:
		var pos = global_transform
		reparent(self, space)
		transform = pos
		on_floor = false
	print("player outside")
	$Camera.zoom = Vector2(1,1)
	ship_interior.monitoring = true

func _physics_process(delta):
	if in_helm :
		if Input.is_action_pressed("ui_up"):
			pass
		if Input.is_action_pressed("ui_down"):
			pass
		pass
#		how am i going to get the signals between the player input and the ship?
#		some kind of control interface?
#		maybe create a resource inputmap for each state ( helm / not helm )
#		https://docs.godotengine.org/en/stable/classes/class_inputmap.html
#		could load it with code from a list of input actions or maybe swap inputmap resources?
#		honestly probably just need to make a proper state machine and use it to tell when and which
#		player is controlling the helms... or just have ship subscribe to signal for helm entered?
		
	else:
		velocity = Vector2.ZERO
		var orientation_dir = Vector2.ZERO
		var input_direction = Input.get_vector("ui_left", "ui_right", "up", "ui_down")
		if on_floor :
				velocity = input_direction.normalized().rotated(ship.transform.get_rotation()) * SPEED
		else:
				velocity = input_direction.normalized() * SPEED
		move_and_slide()
	

func reparent(child: Node, new_parent: Node):
	var old_parent = get_parent()
	old_parent.remove_child(child)
	new_parent.call_deferred("add_child", child)
	child.set_owner(new_parent)

func _helm_entered(body):
	print("helm entered")
	ext_cam.current = true
	in_helm = true

func _helm_exited(body):
	print("helm exited")
	$Camera.current = true
	in_helm = false
