extends Node2D

var counter = 0
var matrix = []

const WIDTH = 7
const HEIGHT = 7
const MAXROOMS = 15
const MINROOMS = 7
const CHANCE = 0.5

# Called when the node enters the scene tree for the first time.
func _ready():
	generate_matrix()
	randomize()
	while counter < MINROOMS:
		clear_matrix()
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
		if randf() > CHANCE:
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




