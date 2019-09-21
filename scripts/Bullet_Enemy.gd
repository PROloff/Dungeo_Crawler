extends Area2D

const SPEED = 170
var move = Vector2()

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

func _process(delta):
	translate(move * delta * SPEED)
	check_for_hit()

func _set_enemyPosition(var pPosition):
	move = pPosition
	
	if move.length() > 1:
		move *= 1/move.length()
	

func _on_VisibilityNotifier2D_screen_exited():
	queue_free()

func _setMove(pMove):
	move = pMove
	if move.length() > 1:
		move = move.normalized()

func _setPosition(pos):
	global_position = pos

func check_for_hit():
	for body in get_overlapping_bodies():
		if body.has_method("player_hit"):
			body.player_hit()
			queue_free()