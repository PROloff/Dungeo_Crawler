extends Node2D

var counter = 0
var matrix = []
var todo = []

const PATH_SPAWN = "res://scenes/Rooms/Spawn.tscn"
const PATH_FINISH = "res://scenes/Rooms/Finish.tscn"
const PATH_ROOM1 = "res://scenes/Rooms/Room1.tscn"
const PATH_ROOM2 = "res://scenes/Rooms/Room2.tscn"
const PATH_ROOM3 = "res://scenes/Rooms/Room3.tscn"
const PATH_ROOM4 = "res://scenes/Rooms/Room4.tscn"
const PATH_ROOM5 = "res://scenes/Rooms/Room5.tscn"
const PATH_ROOM6 = "res://scenes/Rooms/Room6.tscn"
const PATH_ROOM7 = "res://scenes/Rooms/Room7.tscn"
const PATH_ROOM8 = "res://scenes/Rooms/Room8.tscn"
const PATH_ROOM9 = "res://scenes/Rooms/Room9.tscn"
const PATH_ROOM10 = "res://scenes/Rooms/Room10.tscn"
const PATH_ROOM11 = "res://scenes/Rooms/Room11.tscn"
const PATH_ROOM12 = "res://scenes/Rooms/Room12.tscn"
const PATH_ROOM13 = "res://scenes/Rooms/Room13.tscn"
const PATH_ROOM14 = "res://scenes/Rooms/Room14.tscn"
const PATH_ROOM15 = "res://scenes/Rooms/Room15.tscn"
const PATH_ROOM16 = "res://scenes/Rooms/Room16.tscn"
const PATH_ROOM17 = "res://scenes/Rooms/Room17.tscn"
const PATH_ROOM18 = "res://scenes/Rooms/Room18.tscn"
const PATH_ROOM19 = "res://scenes/Rooms/Room19.tscn"
const PATH_ROOM20 = "res://scenes/Rooms/Room20.tscn"


var WIDTH = 11
var HEIGHT = 11
var MAXROOMS = 20
var MINROOMS = 10
const CHANCE = 0.8
const KEYCOUNT = 2
const HEARTROOMCOUNT = 3
const HEARTCHANCE = 0.5
const CHANCEREDUCTION = 0.4 #how much the chance of placing a room decreases based on the neighbour count
const ENEMYCHANCE = 0.4

#onready var ROOM = preload("res://scenes/Rooms/Spawn.tscn")
onready var END = preload("res://scenes/EndGenerated.tscn")
onready var KEY = preload("res://scenes/Key.tscn")
onready var WALL_NORTH = preload("res://scenes/Walls/wall_north.tscn")
onready var WALL_SOUTH = preload("res://scenes/Walls/wall_south.tscn")
onready var WALL_EAST = preload("res://scenes/Walls/wall_east.tscn")
onready var WALL_WEST = preload("res://scenes/Walls/wall_west.tscn")
onready var ENEMY = preload("res://scenes/Slotmachine.tscn")
onready var LEBEN = preload("res://scenes/Leben.tscn")

func _ready():
	generate_matrix()
	randomize()
	while counter < MINROOMS:
		clear_matrix()
		todo.clear()
		todo.append(Vector2(WIDTH/2, HEIGHT/2))
		counter = 0
		while !todo.empty() && counter < MAXROOMS:
			add_room()
	place(2)
	place(3)
	for i in (KEYCOUNT):
		place(4)
	for i in (HEARTROOMCOUNT):
		place(5)
	place_rooms()
	place_objects()
	$KI.raise()
	print(counter)
	print_matrix()
#	$Camera2D.adjust_camera()
	PlayerVariables.keysneeded = KEYCOUNT

func generate_matrix():
	for x in range(WIDTH):
	    matrix.append([])
	    matrix[x]=[]        
	    for y in range(HEIGHT):
	        matrix[x].append([])
	        matrix[x][y]=0

func clear_matrix():
	for y in (HEIGHT):
		for x in (WIDTH):
			matrix[y][x] = 0

func add_room():
	var x = todo.front().x
	var y = todo.front().y
	todo.pop_front()
	if counter < MAXROOMS:
		if matrix[x][y] == 0 && randf() < CHANCE - neighbour_count(x, y) * CHANCEREDUCTION * CHANCE:
			matrix[x][y] = 1
			counter += 1
			if x > 0 && x < WIDTH-1 && y > 0 && y < HEIGHT-1:
				if matrix[x-1][y] == 0:
					todo.append(Vector2(x-1, y))
				if matrix[x+1][y] == 0:
					todo.append(Vector2(x+1, y))
				if matrix[x][y-1] == 0:
					todo.append(Vector2(x, y-1))
				if matrix[x][y+1] == 0:
					todo.append(Vector2(x, y+1))

func print_matrix():
	var output = ""
	for y in (HEIGHT):
		for x in (WIDTH):
			 output += String(matrix[x][y]) + " "
		output += "\n"
	print(output) 

func place(var number):
	var placed = false
	var x
	var y
	while !placed:
		x = randi()%WIDTH
		y = randi()%HEIGHT
		if matrix[x][y] == 1:
			matrix[x][y] = number
			placed = true

func neighbour_count(var x, var y):
	var i = 0
	if (x > 0 && matrix[x-1][y] != 0):
		i += 1
	if (x < WIDTH - 1 && matrix[x+1][y] != 0):
		i += 1
	if (y > 0 && matrix[x][y-1] != 0):
		i += 1
	if (y < HEIGHT - 1 && matrix[x][y+1] != 0):
		i += 1
	return i

func place_rooms():
	for x in range(WIDTH):
		for y in range(HEIGHT):
			if matrix[x][y] != 0:
				var room
				match matrix[x][y]:
					2:
						room = preload(PATH_SPAWN).instance()
					3:
						room = preload(PATH_FINISH).instance()
					1, 4, 5:
						match randi()%20+1:
							1:
								room = preload(PATH_ROOM1).instance()
							2:
								room = preload(PATH_ROOM2).instance()
							3:
								room = preload(PATH_ROOM3).instance()
							4:
								room = preload(PATH_ROOM4).instance()
							5:
								room = preload(PATH_ROOM5).instance()
							6:
								room = preload(PATH_ROOM6).instance()
							7:
								room = preload(PATH_ROOM7).instance()
							8:
								room = preload(PATH_ROOM8).instance()
							9:
								room = preload(PATH_ROOM9).instance()
							10:
								room = preload(PATH_ROOM10).instance()
							11:
								room = preload(PATH_ROOM11).instance()
							12:
								room = preload(PATH_ROOM12).instance()
							13:
								room = preload(PATH_ROOM13).instance()
							14:
								room = preload(PATH_ROOM14).instance()
							15:
								room = preload(PATH_ROOM15).instance()
							16:
								room = preload(PATH_ROOM16).instance()
							17:
								room = preload(PATH_ROOM17).instance()
							18:
								room = preload(PATH_ROOM18).instance()
							19:
								room = preload(PATH_ROOM19).instance()
							20:
								room = preload(PATH_ROOM20).instance()
						var ikey = 0
						if matrix[x][y] == 4:
							ikey = randi()%5+1
						for i in range(1, 6):
							if matrix[x][y] != 5 && randf() < ENEMYCHANCE && i != ikey:
								var enemy = ENEMY.instance()
								$KI.add_child(enemy)
								enemy.position = room._get_position(i) + Vector2(448 * x, 256 * y)
							elif matrix[x][y] == 5 && randf() < HEARTCHANCE:
								var leben = LEBEN.instance()
								$KI.add_child(leben)
								leben.position = room._get_position(i) + Vector2(448 * x, 256 * y)
							elif i == ikey:
								var key = KEY.instance()
								$KI.add_child(key)
								key.position = room._get_position(i) + Vector2(448 * x, 256 * y)
				add_child(room)
				room.position.x = 448 * x
				room.position.y = 256 * y
				place_walls(x, y)

func place_walls(var x, var y):
	if x == 0:
		add_wall(WALL_WEST, x, y)
	elif matrix[x-1][y] == 0:
		add_wall(WALL_WEST, x, y)
	if x == WIDTH - 1:
		add_wall(WALL_EAST, x, y)
	elif matrix[x+1][y] == 0:
		add_wall(WALL_EAST, x, y)
	if y == 0:
		add_wall(WALL_NORTH, x, y)
	elif matrix[x][y-1] == 0:
		add_wall(WALL_NORTH, x, y)
	if y == HEIGHT - 1:
		add_wall(WALL_SOUTH, x, y)
	elif matrix[x][y+1] == 0:
		add_wall(WALL_SOUTH, x, y)

func add_wall(var wall_type, var x, var y):
	var wall = wall_type.instance()
	add_child(wall)
	wall.position.x = x * 448
	wall.position.y = y * 256
	
func place_objects():
	for x in range(WIDTH):
		for y in range(HEIGHT):
			if matrix[x][y] == 2:
				$KI._set_Player_Position(Vector2(448 * x + 224, 256 * y + 128))
			if matrix[x][y] == 3:
				var end = END.instance()
				add_child(end)
				end.position.x = 448 * x + 224
				end.position.y = 256 * y + 128