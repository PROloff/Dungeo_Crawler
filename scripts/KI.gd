extends Node2D

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
onready var pPlayer = get_node("Player")
onready var pEnemy = get_node("Enemy")
var a
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func _process(delta):
	a = pPlayer._get_Position()
	pEnemy._set_Player_Position(a)
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
