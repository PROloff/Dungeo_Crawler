extends KinematicBody2D

var SPEED = 50

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var move = Vector2(0,0)
	
	if Input.is_action_pressed("down"):
		move.y = 1
	if Input.is_action_pressed("up"):
		move.y = -1
	if Input.is_action_pressed("left"):
		move.x = -1
	if Input.is_action_pressed("right"):
		move.x = 1
	
	move_and_slide(move * SPEED)
	pass
