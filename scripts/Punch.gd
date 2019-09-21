extends Area2D

const COOLDOWN = 30

var cooldown = 0


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if cooldown > 0:
		cooldown -= 1


func hit():
	if cooldown == 0:
		cooldown = COOLDOWN
		for body in get_overlapping_bodies():
			if body.has_method("is_hit"):
				body.is_hit()
