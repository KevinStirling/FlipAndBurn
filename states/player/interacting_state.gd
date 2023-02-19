extends State

class_name InteractingState


func _ready():
	animated_sprite.play("RESET")
	
func _physics_process(delta):
	pass

func move(input_direction_rotated : Vector2):
	pass
	
