extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass

func _get_position(var i):
	match i:
		1:
			return $Position2D.position
		2:
			return $Position2D2.position
		3:
			return $Position2D3.position
		4:
			return $Position2D4.position
		5:
			return $Position2D5.position

