extends Area2D

const COOLDOWN = 30
onready var swingSound=get_tree().get_root().get_node("Game").get_node("BilliardSchwung")
onready var hitSound=get_tree().get_root().get_node("Game").get_node("BilliardHit")
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
		swingSound.play()
		for body in get_overlapping_bodies():
			if body.has_method("is_hit"):
				hitSound.play()
				body.is_hit()
