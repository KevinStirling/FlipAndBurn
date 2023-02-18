extends State

class_name RunState

var move_speed = 350.0

func _ready():
	animated_sprite.play("run")

func move(input_direction_rotated : Vector2):
	persistent_state.velocity = input_direction_rotated * move_speed 
	if persistent_state.velocity == Vector2.ZERO:
		persistent_state.change_state("idle")
