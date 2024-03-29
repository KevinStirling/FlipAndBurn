extends Area2D

@onready var ship = get_node("/root/Space/Ship")
@onready var ext_cam = get_node("/root/Space/Ship/ExternalCamera")
@onready var player_cam = get_node("/root/Space/Ship/Player/Camera")

var body_in_area

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func _on_body_entered(body):
	print(body, " entered")
#	probably should change this check to a group, not node name
	if body.name == "Player":
		body.state.interactable = self
		body_in_area = body
		$AnimationPlayer.play("alert")
		$InAreaAlert.visible = true

func _on_body_exited(body):
	print(body, " exited")
	if body == body_in_area:
		body.state.interactable = null
		body_in_area = null
		$AnimationPlayer.stop()
		$InAreaAlert.visible = false

func interact():
	ship.player_in_helm = true
	player_cam.enabled = false
	ext_cam.enabled = true
	body_in_area.change_state("interacting")
	$AnimationPlayer.stop()
	$InAreaAlert.visible = false
	

func leave():
	ship.player_in_helm = false
	player_cam.enabled = true
	ext_cam.enabled = false
	body_in_area.change_state("idle")
	$AnimationPlayer.play("alert")
	$InAreaAlert.visible = true

