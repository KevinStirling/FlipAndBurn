extends State

class_name IdleState

# Called when the node enters the scene tree for the first time.
func _ready():
	animated_sprite.play("RESET")

func move(input_direction_rotated : Vector2):
	if input_direction_rotated != Vector2.ZERO:
		persistent_state.change_state("walk")
