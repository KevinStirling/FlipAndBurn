extends Node

class_name State

var change_state
var animated_sprite
var persistent_state
var interactable
var velocity = Vector2.ZERO


func _physics_process(_delta):
	velocity = persistent_state.velocity
	interactable = change_state.interactable
	persistent_state.move_and_slide()

func setup(change_state, animated_sprite, persistent_state, interactable):
	self.change_state = change_state
	self.animated_sprite = animated_sprite
	self.persistent_state = persistent_state
	self.interactable = interactable
	

func move(_input_direction_rotated : Vector2):
	pass

func interact(_interactable):
	if change_state.name != "interacting" && interactable != null:
		_interactable.interact()
	elif change_state.name == "interacting":
		_interactable.leave()
