extends Control
#onready var clickSound=get_tree().get_root().get_node("Title Screen").get_node("Click")
func _ready():
	$ScoreSchatten/Score.set_text("You beat " + String(PlayerVariables.score) + " stages")
	$ScoreSchatten.set_text("You beat " + String(PlayerVariables.score) + " stages")

#func _process(delta):
#	pass

func _on_Button_Start_pressed():
#	clickSound.play()
	PlayerVariables.reset()
	get_tree().change_scene("res://scenes/RandomLevel.tscn")
	pass # Replace with function body.




func _on_Butto_Menu_pressed():
#	clickSound.play()
	get_tree().change_scene("res://scenes/Title Screen.tscn")
