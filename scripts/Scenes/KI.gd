extends Node2D

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
onready var pPlayer = get_node("Player")
var a
var timer = 0.0

# Called when the node enters the scene tree for the first time.
func _ready():
	a = pPlayer._get_Position()
	pass # Replace with function body.

func _set_Player_Position(var p):
	$Player.position = p

func _process(delta):
	a = pPlayer._get_Position()
	$Camera2D.position.x = int(a.x) - int(a.x)%448
	$Camera2D.position.y = int(a.y) - int(a.y)%256
	timer += delta
	if timer > 0.2:
		print("fps: " + str(Engine.get_frames_per_second()))
		timer = 0.0

func _give_Player_Position():
	return a