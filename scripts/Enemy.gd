extends KinematicBody2D

onready var deathSound=get_node("DeathSound")

var PLAYERPOSX
var PLAYERPOSY
var VIEWDISTANCE = 0
var MOVEDISTANCE = 0
var FARDISTANCE = 256
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
	var pos = get_parent()._set_Player_Position()
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
	if move.length() < VIEWDISTANCE || move.length() > FARDISTANCE:
		move.x = 0
		move.y = 0
		$AnimatedSprite.play("idle")
	else:
		$AnimatedSprite.play("walk")
	
	if !move.is_normalized():
		move = move.normalized()
	

func is_hit(var x):
	life -= x
	if life <= 0:
		queue_free()
		deathSound.play()
		get_parent()._destroy()
		
func  _setSPEED(speed):
	SPEED = speed

func _setLifes(lifes):
	life =lifes

func _setViewDistance(distance):
	VIEWDISTANCE = distance

func _setMoveDistance (dis):
	MOVEDISTANCE = dis