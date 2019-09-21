extends KinematicBody2D

var PLAYERPOSX
var PLAYERPOSY
var SPEED = 40
var ROLLSPEED = 1
var ROLLLENGTH = 60
var rollDirection = Vector2(0,0)
var rollCounter = 0
var RNG = RandomNumberGenerator.new()
var move = Vector2(0,0)
# Called when the node enters the scene tree for the first time.


func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	_calculate_move()
	move_and_slide(move * SPEED)
	pass

func _set_Player_Position(pos):
	PLAYERPOSX = pos.x
	PLAYERPOSY = pos.y
	pass

func _calculate_move():
	
	var posX = global_position.x
	var posY = global_position.y
	
	var deltaY = PLAYERPOSY - posY
	var deltaX = PLAYERPOSX - posX
	move.x = deltaX
	move.y = deltaY
	if move.length() > 100:
		move.x = 0
		move.y = 0
	
	if !move.is_normalized():
		move = move.normalized()
	pass