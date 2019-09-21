extends Node2D

onready var pEnemy = get_node("Enemy")
const BULLET = preload("res://scenes/Bullet_Enemy.tscn")
var PLAYERPOSX
var PLAYERPOSY
var viewDistance = 500
var moveDistance = 50
var speed = 20 #movement
var lifes = 20
var move = Vector2(0,0)
var bulletDirection
var isShooting = true
var timeSinceShoot = 0.0
var shootDelay = 5.5
var positions
var timeSincePositionSaved = 0.0
# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Called when the node enters the scene tree for the first time.
func _ready():
	positions = PoolVector2Array()
	pEnemy._setLifes(lifes)
	pEnemy._setSPEED(speed)
	pEnemy._setViewDistance(viewDistance)
	pEnemy._setMoveDistance(moveDistance)
	pass # Replace with function body.

func _process(delta):
	_set_Player_Position()
	_calculateBulletDirection()
	timeSincePositionSaved +=delta
	
	if isShooting:
		timeSinceShoot += delta
	
	if timeSinceShoot > shootDelay:
		isShooting = false;
		timeSinceShoot = 0.0;
	
	if timeSincePositionSaved > 0.5:
		_savePos()
		timeSincePositionSaved = 0.0
	
	pass

func _attack():
	var bullet = BULLET.instance()
	get_parent().add_child(bullet)
	bullet._set_enemyPosition(global_position)
	bullet._setMove(bulletDirection)
	bullet._setPosition(pEnemy.global_position)
	

func _set_Player_Position():
	var pos = get_parent()._give_Player_Position()
	PLAYERPOSX = pos.x
	PLAYERPOSY = pos.y
	return pos

func _savePos():
	var temp = Vector2(PLAYERPOSX, PLAYERPOSY)
	positions.append(temp)
	pass

func _playerPosAtDelta(delta):
	var a = Vector2(PLAYERPOSX, PLAYERPOSY)
	var x = delta
	var r = Vector2(0,0)
	var positon = Vector2(1,1)
	
	
	return position

func _calculateInterception():
	
	pass

func _calculateBulletDirection():
	bulletDirection = Vector2(0,0)
	var posX = pEnemy.global_position.x
	var posY = pEnemy.global_position.y
	var deltaY = PLAYERPOSY - posY
	var deltaX = PLAYERPOSX - posX
	bulletDirection.x = deltaX
	bulletDirection.y = deltaY
	
	
	
	
	
	if bulletDirection.length() < viewDistance && !isShooting:
		if !bulletDirection.is_normalized():
			bulletDirection = bulletDirection.normalized()
		_attack()
		isShooting = true
	pass

func _destroy():
	queue_free()