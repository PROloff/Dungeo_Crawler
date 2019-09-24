extends Node2D

var counter = 0
var matrix = []

const WIDTH = 7
const HEIGHT = 7
const MAXROOMS = 20
const MINROOMS = 10
const CHANCE = 0.5
const CHANCEREDUCTION = 1 #how much the chance of placing a room decreases based on the neighbour count

# Called when the node enters the scene tree for the first time.
func _ready():
	generate_matrix()
	randomize()
	while counter < MINROOMS:
		clear_matrix()
		counter = 0
		add_room(WIDTH/2, HEIGHT/2)
	print(counter)
	print_matrix()
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


