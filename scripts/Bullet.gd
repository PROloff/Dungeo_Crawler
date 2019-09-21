extends Area2D

const SPEED = 400
var move = Vector2()

# Called when the node enters the scene tree for the first time.
func _ready():
	#input direction
	if Input.is_action_pressed("down"):
		move.y = 1
	if Input.is_action_pressed("up"):
		move.y = -1
	if Input.is_action_pressed("left"):
		move.x = -1
	if Input.is_action_pressed("right"):
		move.x = 1
	#normalize speed
	if move.length() > 1:
		move *= 0.71

func _process(delta):
	translate(move * SPEED * delta)


func _on_VisibilityNotifier2D_screen_exited():
	queue_free()
