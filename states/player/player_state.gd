extends CharacterBody2D

class_name PlayerState

var state
var state_factory

func change_state(new_state_name):
	var interactable
	if state != null:
		interactable = state.interactable
		state.queue_free()
	state = state_factory.get_state(new_state_name).new()
	state.setup(state, $AnimationPlayer, self, interactable)
	state.name = new_state_name
	add_child(state)

func move(input_direction_rotated : Vector2):
	state.move(input_direction_rotated)
