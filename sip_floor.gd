extends Area2D

@onready var ship_interior = $ShipBaseCollision

func _ready():
	body_entered.connect(_player_entered_ship)
	body_exited.connect(_player_exited_ship)

func _player_entered_ship(body):
	print("player inside")

func _player_exited_ship(body):
	print("player outside")
