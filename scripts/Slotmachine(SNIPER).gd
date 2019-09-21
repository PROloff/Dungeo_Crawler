extends Node2D

onready var pEnemy = get_node("Enemy")
const BULLET = preload("res://scenes/Bullet_Enemy.tscn")
var PLAYERPOSX
var PLAYERPOSY
var viewDistance = 350
var moveDistance = 50
var speed = 20 #movement
var lifes = 20
var move = Vector2(0,0)
var bulletDirection
var isShooting = false
var timeSinceShoot = 0.0
var shootDelay = 3.3
var POSITIONS = PoolVector2Array()
var timeSincePositionSaved = 0.0
# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Called when the node enters the scene tree for the first time.
func _ready():
	pEnemy._setLifes(lifes)
	pEnemy._setSPEED(speed)
	pEnemy._setViewDistance(viewDistance)
	pEnemy._setMoveDistance(moveDistance)
	pass # Replace with function body.

func _process(delta):
	_set_Player_Position()
	_calculateBulletDirection()
	timeSincePositionSaved += delta
	
	if isShooting:
		timeSinceShoot += delta
	
	if timeSinceShoot > shootDelay:
		print("attack")
		isShooting = false
		_attack()
		timeSinceShoot = 0.0
	
	if timeSincePositionSaved > shootDelay/10:
		_savePos()
		timeSincePositionSaved = 0.0
	
	pass

func _attack():
	var bullet = BULLET.instance()
	get_parent().add_child(bullet)
	bullet._set_enemyPosition(global_position)
	bullet._setMove(bulletDirection)
	bullet._setPosition(pEnemy.global_position)
	POSITIONS = PoolVector2Array()

func _set_Player_Position():
	var posi = get_parent()._give_Player_Position()
	PLAYERPOSX = posi.x
	PLAYERPOSY = posi.y
	return posi
	
func _savePos():
	print (POSITIONS.size())
	var temp = Vector2(PLAYERPOSX, PLAYERPOSY)
	POSITIONS.append(temp)

func _playerPosAtDelta(delta):
	var a = Vector2(PLAYERPOSX, PLAYERPOSY)
	var x = delta
	var r = Vector2(0,0)
	var positionFinal = Vector2(1,1)
	if POSITIONS.size() > 0:
		var preaviousPos = POSITIONS[0]
		for pos in POSITIONS:
			r+=preaviousPos-pos
			preaviousPos = pos
			pass
		r = r / POSITIONS.size()
	positionFinal = a+ (delta* r)
	return positionFinal

func _calculateInterception():
	var posPlayerAtDelta
	var posBulletOnDelta
	
	pass

func _calculateBulletDirection():
	bulletDirection = Vector2(0,0)
	var posX = pEnemy.global_position.x
	var posY = pEnemy.global_position.y
	var epos = _playerPosAtDelta(10)
	var deltaY = epos.y - posY
	var deltaX = epos.x - posX
	bulletDirection.x = deltaX
	bulletDirection.y = deltaY
	if bulletDirection.length() < viewDistance && !isShooting:
		if !bulletDirection.is_normalized():
			bulletDirection = bulletDirection.normalized()
		print(bulletDirection)
		isShooting = true
	pass

func _destroy():
	queue_free()