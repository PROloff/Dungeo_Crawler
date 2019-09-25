extends Node2D

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
onready var pPlayer = get_node("Player")
var a
# Called when the node enters the scene tree for the first time.
func _ready():
	a = pPlayer._get_Position()
	pass # Replace with function body.

func _set_Player_Position(var p):
	$Player.position = p

func _process(delta):
	a = pPlayer._get_Position()

func _give_Player_Position():
	return a

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
