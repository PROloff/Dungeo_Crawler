extends Node2D

onready var pEnemy = get_node("Enemy")
const BULLET = preload("res://scenes/Bullet_Enemy.tscn")
var PLAYERPOSX
var PLAYERPOSY
var viewDistance = 500
var speed = 20
var lifes = 20
var bulletDirection
# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Called when the node enters the scene tree for the first time.
func _ready():
	pEnemy._setLifes(lifes)
	pEnemy._setSPEED(speed)
	pEnemy._setViewDistance(viewDistance)
	pass # Replace with function body.

func _process(delta):
	_set_Player_Position()
	
	pass

func _attack():
	var bullet = BULLET.instance()
	get_parent().add_child(bullet)
	bullet._set_enemyPosition(position)
	bullet.position = $Position2D.global_position

func _set_Player_Position():
	var pos = get_parent()._give_Player_Position()
	print (pos)
	PLAYERPOSX = pos.x
	PLAYERPOSY = pos.y
	return pos

func _calculateBulletDirection():
	bulletDirection = Vector2(0,0)
	var posX = global_position.x
	var posY = global_position.y

	var deltaY = PLAYERPOSY - posY
	var deltaX = PLAYERPOSX - posX
	bulletDirection.x = deltaX
	bulletDirection.y = deltaY
	if !bulletDirection.is_normalized():
		bulletDirection = bulletDirection.normalized()
	BULLET._setMove(bulletDirection)
	pass
