extends Node2D

const ROOM = preload("res://scenes/MapRoom.tscn")

var localmap = []

func _ready():
	pass

func _process(delta):
	if localmap.size() > 0:
		update_map()
	else:
		generate_map()

func update_map():
	var map = PlayerVariables.map
	for x in map.size():
		for y in map[0].size():
			localmap[x][y].frame = map[x][y]

func generate_map():
	for x in range(PlayerVariables.map.size()):
		localmap.append([])
		localmap[x]=[]        
		for y in range(PlayerVariables.map[0].size()):
			localmap[x].append([])
			var room = ROOM.instance()
			room.position.x = x*6
			room.position.y = y*6
			add_child(room)
			localmap[x][y] = room