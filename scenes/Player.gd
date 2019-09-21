extends KinematicBody2D
onready var player=get_tree().get_root().get_node("Game").get_node("AudioStreamPlayer")
var SPEED = 50

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var move = Vector2(0,0)
	#Movement
	if Input.is_action_pressed("down"):
		move.y = 1
	if Input.is_action_pressed("up"):
		move.y = -1
	if Input.is_action_pressed("left"):
		move.x = -1
	if Input.is_action_pressed("right"):
		move.x = 1
	
	#Sound Start
	if Input.is_action_just_pressed("up") or Input.is_action_just_pressed("down") or Input.is_action_just_pressed("left") or Input.is_action_just_pressed("right") :
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
	

	move_and_slide(move * SPEED)
	pass
