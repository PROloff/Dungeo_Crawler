extends Node2D
onready var clickSound=get_tree().get_root().get_node("Credits").get_node("Click")
onready var kSound=get_node("AudioStreamPlayer")
# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Called when the node enters the scene tree for the first time.
func _ready():
	kSound.play()
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func _on_Button_Back_pressed():
	clickSound.play()
	get_tree().change_scene("res://scenes/Title Screen.tscn")
	pass # Replace with function body.
