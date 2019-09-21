extends KinematicBody2D

var PLAYERPOSX
var PLAYERPOSY
var SPEED = 40
var move = Vector2(0,0)
var life = 3


func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	_set_Player_Position()
	_calculate_move()
	move_and_slide(move * SPEED)
	pass

func _set_Player_Position():
	var pos = get_parent()._give_Player_Position()
	PLAYERPOSX = pos.x
	PLAYERPOSY = pos.y
	pass

func _calculate_move():
	
	get_parent()._calculate_MOVE()
#	var posX = global_position.x
#	var posY = global_position.y
#
#	var deltaY = PLAYERPOSY - posY
#	var deltaX = PLAYERPOSX - posX
#	move.x = deltaX
#	move.y = deltaY
#	if move.length() > 100:
#		move.x = 0
#		move.y = 0
#
#	if !move.is_normalized():
#		move = move.normalized()
	pass
	
func is_hit():
	life =- 1
	if life == 0:
		queue_free()
		
func  _setSPEED(speed):
	SPEED = speed

func _setLifes(lifes):
	life =lifes