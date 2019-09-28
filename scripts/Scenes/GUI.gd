extends Node2D

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	$Keys.text = String(int(PlayerVariables.keyscollected)) + " / " + String(int(PlayerVariables.keysneeded))
	$Score.text = "Stage: " + String(PlayerVariables.score)
	update_minimap()

func update_minimap():
	var output = ""
	for y in (PlayerVariables.map.size()):
		for x in (PlayerVariables.map[0].size()):
			output += PlayerVariables.map[x][y]
		output += "\n"
	$Minimap.text = output
