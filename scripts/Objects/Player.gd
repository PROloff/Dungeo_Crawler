extends KinematicBody2D

onready var dashS=get_node("Dash")
onready var bulletS=get_node("BulletSound")
onready var player=get_node("AudioStreamPlayer")
onready var justin=get_node("ICEDOUT")
onready var background=get_node("Background")

const SPEED = 100
const ROLLSPEED = 300
const ROLLLENGTH = 40
const COOLDOWNLENGTH = 40
const BULLETCOOLDOWN = 30

const BULLET = preload("res://scenes/Bullet.tscn")

var keycount = 0
var bulletcooldown = 0
var rollDirection = Vector2(0,0)
var rollCounter = 0
var life = 5
var weapon = 1

# Called when the node enters the scene tree for the first time.
func _ready():
	justin.play()
	background.play()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var move = Vector2(0,0)
	#input direction
	if Input.is_action_pressed("down"):
		move.y += 1
	if Input.is_action_pressed("up"):
		move.y -= 1
	if Input.is_action_pressed("left"):
		move.x -= 1
		$AnimatedSprite.flip_h = true
		$Disc.position.x = -5
		$Punch.position.x = -4.144
		#$Punch._flip_h(true)
		$Position2D.position.x = -5
	if Input.is_action_pressed("right"):
		move.x += 1
		$AnimatedSprite.flip_h = false
		$Disc.position.x = 5
		$Punch.position.x = 4.144
		#$Punch._flip_h(true)
		$Position2D.position.x = 5
	#normalize speed
	if move.length() > 1:
		move = move.normalized()
	if move.length() > 0:
		if rollCounter > COOLDOWNLENGTH:
			$AnimatedSprite.play("dash")
		else:
			$AnimatedSprite.play("walk")
	else:
		$AnimatedSprite.play("idle")
	#input roll
	if move.length() > 0 && Input.is_action_just_pressed("roll") && rollCounter <= 0:
		rollCounter = ROLLLENGTH + COOLDOWNLENGTH
		rollDirection = move
		dashS.play()
	#roll cooldown
	if rollCounter > 0:
		rollCounter -= 175 * delta
	#move
	if rollCounter > COOLDOWNLENGTH:
		move_and_slide(rollDirection * ROLLSPEED)
	else:
		move_and_slide(move * SPEED)
	#switch weapon
	if Input.is_action_just_pressed("switch"):
		weapon *= -1
		if weapon == 1:
			$Disc.visible = true
			$Punch.visible = false
		else:
			$Disc.visible = false
			$Punch.visible = true
	
	if bulletcooldown >= 0:
		bulletcooldown -= 100 * delta
	#attack
	if Input.is_action_just_pressed("attack"):
		if weapon == 1:
			if bulletcooldown <= 0:
				bulletcooldown = BULLETCOOLDOWN
				var bullet = BULLET.instance()
				get_parent().add_child(bullet)
				bulletS.play()
				bullet._set_playerPosition(position)
				bullet.position = $Position2D.global_position
		else:
			$Punch.hit()
	
	if weapon == -1:
		$Punch.rotation = (- position + get_global_mouse_position()).angle()
		if $Punch.rotation > 1.57 || $Punch.rotation < -1.57:
			$Punch.scale.y = -1
		else: 
			$Punch.scale.y = 1
	
	
	if Input.is_action_pressed("up") or Input.is_action_pressed("down") or Input.is_action_pressed("left") or Input.is_action_pressed("right") :
		if !player.is_playing():
			player.play()
	elif Input.is_action_just_released("up") and !Input.is_action_pressed("down") and !Input.is_action_pressed("left") and !Input.is_action_pressed("right"):
		player.stop()
	elif Input.is_action_just_released("down")and !Input.is_action_pressed("up") and !Input.is_action_pressed("left") and !Input.is_action_pressed("right"):
		player.stop()
	elif Input.is_action_just_released("left")and !Input.is_action_pressed("down") and !Input.is_action_pressed("up") and !Input.is_action_pressed("right"):
		player.stop()
	elif Input.is_action_just_released("right")and !Input.is_action_pressed("down") and !Input.is_action_pressed("left") and !Input.is_action_pressed("up"):
		player.stop()


func player_hit():
	life -= 1
	if life == 0:
		get_tree().change_scene("res://scenes/End Screen.tscn")
	if life == 2:
		$AnimatedSprite2.frame = 3
	if life == 1:
		$AnimatedSprite2.frame = 4
	if life == 3:
		$AnimatedSprite2.frame = 2
	if life == 4:
		$AnimatedSprite2.frame = 1
	if life == 5:
		$AnimatedSprite2.frame = 0

func gain_life():
	if life < 5:
		life += 1
	if life == 3:
		$AnimatedSprite2.frame = 2
	if life == 2:
		$AnimatedSprite2.frame = 3
	if life == 1:
		$AnimatedSprite2.frame = 4
	if life == 4:
		$AnimatedSprite2.frame = 1
	if life == 5:
		$AnimatedSprite2.frame = 0

func gain_key():
	keycount += 1

func has_key():
	return keycount > 0
	
func _get_Position():
	return global_position