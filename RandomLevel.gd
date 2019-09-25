extends Node2D

var counter = 0
var matrix = []

const WIDTH = 3
const HEIGHT = 3
const MAXROOMS = 9
const MINROOMS = 4
const CHANCE = 0.5
const KEYCOUNT = 1
const CHANCEREDUCTION = 0.8 #how much the chance of placing a room decreases based on the neighbour count

onready var ROOM = preload("res://scenes/Rooms/Spawn.tscn")
onready var PLAYER = preload("res://scenes/Player.tscn")
onready var END = preload("res://scenes/END2.tscn")
onready var KEY = preload("res://scenes/Key.tscn")
onready var WALL_NORTH = preload("res://scenes/Walls/wall_north.tscn")
onready var WALL_SOUTH = preload("res://scenes/Walls/wall_south.tscn")
onready var WALL_EAST = preload("res://scenes/Walls/wall_east.tscn")
onready var WALL_WEST = preload("res://scenes/Walls/wall_west.tscn")

func _ready():
	generate_matrix()
	randomize()
	while counter < MINROOMS:
		clear_matrix()
		counter = 0
		add_room(WIDTH/2, HEIGHT/2)
	print(counter)
	place(2)
	place(3)
	for i in (KEYCOUNT):
		place(4)
	print_matrix()
	place_rooms()
	place_objects()
	pass # Replace with function body.

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

func add_room(var x, var y):
	if counter < MAXROOMS:
		if matrix[x][y] == 0 && randf() < CHANCE - neighbour_count(x, y) * CHANCEREDUCTION * CHANCE:
			matrix[x][y] = 1
			counter += 1
			if x > 0 && x < WIDTH-1 && y > 0 && y < HEIGHT-1:
				if matrix[x-1][y] == 0:
					add_room(x-1, y)
				if matrix[x+1][y] == 0:
					add_room(x+1, y)
				if matrix[x][y-1] == 0:
					add_room(x, y-1)
				if matrix[x][y+1] == 0:
					add_room(x, y+1)

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
	if (x > 0 && matrix[x-1][y]):
		i += 1
	if (x > 0 && matrix[x-1][y]):
		i += 1
	if (x > 0 && matrix[x-1][y]):
		i += 1
	if (x > 0 && matrix[x-1][y]):
		i += 1
	return i

func place_rooms():
	for x in range(WIDTH):
		for y in range(HEIGHT):
			if matrix[x][y] != 0:
				var room = ROOM.instance()
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
	print("add" + String(x) + String(y))
	var wall = wall_type.instance()
	add_child(wall)
	wall.position.x = x * 448
	wall.position.y = y * 256
	
func place_objects():
	for x in range(WIDTH):
		for y in range(HEIGHT):
			if matrix[x][y] == 2:
				var player = PLAYER.instance()
				add_child(player)
				player.position.x = 448 * x + 224
				player.position.y = 256 * y + 128
			if matrix[x][y] == 3:
				var end = END.instance()
				add_child(end)
				end.position.x = 448 * x + 224
				end.position.y = 256 * y + 128
			if matrix[x][y] == 4:
				var key = KEY.instance()
				add_child(key)
				key.position.x = 448 * x + 224
				key.position.y = 256 * y + 128