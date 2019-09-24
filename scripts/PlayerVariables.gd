extends Node

const MAXHP = 5

var leben

# Called when the node enters the scene tree for the first time.
func _ready():
	leben = MAXHP
	pass # Replace with function body.

func gain_life():
	if leben < MAXHP:
		leben += 1

func lose_life():
	if leben > 0:
		leben -= 1

func is_dead():
	return leben == 0

func reset_life():
	leben = MAXHP