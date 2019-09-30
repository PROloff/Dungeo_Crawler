extends Node

const MAXHP = 5

var score = 0
var leben
var keysneeded
var keyscollected = 0

var map = []

# Called when the node enters the scene tree for the first time.
func _ready():
	leben = MAXHP
	pass # Replace with function body.

func gain_score():
	score += 1

func gain_life():
	if leben < MAXHP:
		leben += 1

func lose_life():
	if leben > 0:
		leben -= 1

func is_dead():
	return leben == 0

func reset():
	leben = MAXHP
	score = 0

func generate_matrix(var width, var height):
	var matrix = []
	for x in range(width):
	    matrix.append([])
	    matrix[x]=[]        
	    for y in range(height):
	        matrix[x].append([])
	        matrix[x][y]=0
	return matrix