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
	var outputPlayer = ""
	var outputZiel = ""
	var outputStart = ""
	for y in (PlayerVariables.map.size()):
		for x in (PlayerVariables.map[0].size()):
			match PlayerVariables.map[x][y]:
				0:
					output += " "
					outputPlayer += " "
					outputStart += " "
					outputZiel += " "
				1:
					output += "0"
					outputPlayer += " "
					outputStart += " "
					outputZiel += " "
				2:
					output += " "
					outputPlayer += "0"
					outputStart += " "
					outputZiel += " "
				3:
					output += " "
					outputPlayer += " "
					outputStart += "0"
					outputZiel += " "
				4:
					output += " "
					outputPlayer += " "
					outputStart += " "
					outputZiel += "0"
		output += "\n"
		outputPlayer += "\n"
		outputStart += "\n"
		outputZiel += "\n"
	$Minimap.text = output
	$MinimapPlayer.text = outputPlayer
	$MinimapStart.text = outputStart
	$MinimapZiel.text = outputZiel
