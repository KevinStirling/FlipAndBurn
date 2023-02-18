extends CharacterBody2D

class_name PlayerState

var state
var state_factory

func change_state(new_state_name):
	if state != null:
		state.queue_free()
	state = state_factory.get_state(new_state_name).new()
	state.setup(state, $AnimationPlayer, self)
	state.name = "current_state"
	add_child(state)
	print(new_state_name)

func move(input_direction_rotated : Vector2):
	state.move(input_direction_rotated)
