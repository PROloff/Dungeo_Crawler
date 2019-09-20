extends KinematicBody2D

var SPEED = 50
var ROLLSPEED = 1
var ROLLLENGTH = 60
var rollDirection = Vector2(0,0)
var rollCounter = 0

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
	if move.length() > 1:
		move *= 0.71
	if move.length() > 0 && Input.is_action_just_pressed("roll") && rollCounter == 0:
		rollCounter = ROLLLENGTH
		rollDirection = move
	if rollCounter > 0:
		rollCounter -= 1
		move_and_collide(rollDirection * ROLLSPEED)
	else:
		move_and_slide(move * SPEED)
	pass
