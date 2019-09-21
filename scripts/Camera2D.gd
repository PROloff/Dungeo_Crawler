extends Camera2D

onready var player = get_parent().get_node("Player")

func _ready():
	pass

func _process(time):
	
	if(player.is_on_screen == false):
		print("camera:")
		print(position.x)
		#print("player:")
		#print(player.position.x)
		if(player.position.x > position.x+30):
			position.x += 448
		if(player.position.x < position.x-30):
			position.x -= 448
		if(player.position.y > position.y+30):
			position.y += 256
		if(player.position.y < position.y-30):
			position.y -= 256
		pass