extends Camera2D

onready var player=get_tree().get_root().get_node("Game").get_node("Player")

func _ready():
	pass

func _process(delta):
	if(player.is_on_screen == true):
		current = true
	else:
		current = false