extends Node2D

const spawn = "res://scenes/Rooms/Spawn.tscn"
const finish = "res://scenes/Rooms/Finish.tscn"
const room = "res://scenes/Rooms/Room1.tscn"

func _ready():
	pass

func get_room(var i):
	if i == 2:
		return spawn
	if i == 3:
		return finish
	if i == 1:
		return room
	if i == 2:
		return spawn