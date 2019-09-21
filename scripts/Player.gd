extends KinematicBody2D

onready var dashS=get_tree().get_root().get_node("Game").get_node("Dash")
onready var bulletS=get_tree().get_root().get_node("Game").get_node("BulletSound")
onready var player=get_tree().get_root().get_node("Game").get_node("AudioStreamPlayer")

const SPEED = 100
const ROLLSPEED = 250
const ROLLLENGTH = 60
const COOLDOWNLENGTH = 120

const BULLET = preload("res://scenes/Bullet.tscn")

var rollDirection = Vector2(0,0)
var rollCounter = 0
var life = 3
var weapon = 1

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

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
		$Position2D.position.x = -5
	if Input.is_action_pressed("right"):
		move.x += 1
		$AnimatedSprite.flip_h = false
		$Disc.position.x = 5
		$Position2D.position.x = 5
	#normalize speed
	if move.length() > 1:
		move *= 0.71
	if move.length() > 0:
		if rollCounter > COOLDOWNLENGTH:
			$AnimatedSprite.play("dash")
		else:
			$AnimatedSprite.play("walk")
	else:
		$AnimatedSprite.play("idle")
	#input roll
	if move.length() > 0 && Input.is_action_just_pressed("roll") && rollCounter == 0:
		rollCounter = ROLLLENGTH + COOLDOWNLENGTH
		rollDirection = move
		dashS.play()
	#roll cooldown
	if rollCounter > 0:
		rollCounter -= 1
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
	#attack
	if Input.is_action_just_pressed("attack"):
		if weapon == 1:
			var bullet = BULLET.instance()
			get_parent().add_child(bullet)
			bulletS.play()
			bullet._set_playerPosition(position)
			bullet.position = $Position2D.global_position
		else:
			$Punch.hit()
	
	if weapon == -1:
		$Punch.rotation = (- position + get_global_mouse_position()).angle()
	

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

	
func _get_Position():
	return global_position