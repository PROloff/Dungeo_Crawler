extends Area2D

const COOLDOWN = 0
onready var swingSound=get_node("BilliardSchwung")
onready var hitSound=get_node("BilliardHit")
var cooldown = 0
var hitting = false

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if cooldown > 0 && hitting == false:
		cooldown -= 1


func hit():
	if cooldown == 0 && hitting == false:
		$AnimatedSprite.play("swing")
		cooldown = COOLDOWN
		hitting = true
		swingSound.play()
		for body in get_overlapping_bodies():
			if body.has_method("is_hit"):
				hitSound.play()
				body.is_hit(10)


func _on_AnimatedSprite_animation_finished():
	$AnimatedSprite.play("idle")
	hitting = false


func _flip_h(var x):
	$AnimatedSprite.flip_h = x