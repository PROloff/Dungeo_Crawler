extends Camera2D

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

func adjust_camera():
	offset.x = get_parent().HEIGHT * 224 
	offset.y = get_parent().WIDTH * 128 
	if get_parent().HEIGHT > get_parent().WIDTH:
		zoom.x = get_parent().HEIGHT
		zoom.y = get_parent().HEIGHT
	else:
		zoom.x = get_parent().WIDTH
		zoom.y = get_parent().WIDTH