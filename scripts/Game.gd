extends Node2D
onready var justin=get_tree().get_root().get_node("Game").get_node("ICEDOUT")
onready var background=get_tree().get_root().get_node("Game").get_node("Background")

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Called when the node enters the scene tree for the first time.
func _ready():
	pass 
	justin.play()
	background.play()

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
