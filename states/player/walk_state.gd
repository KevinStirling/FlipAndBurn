extends State

class_name WalkState

var move_speed = 200.0

func _ready():
	animated_sprite.play("walk")

func move(input_direction_rotated : Vector2):
	persistent_state.velocity = input_direction_rotated * move_speed 
	if persistent_state.velocity == Vector2.ZERO:
		persistent_state.change_state("idle")

#func interact(interactable : Node2D):
#	pass
