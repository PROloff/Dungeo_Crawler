extends Node2D

onready var justin=get_tree().get_root().get_node("Game").get_node("ICEDOUT")
onready var background=get_tree().get_root().get_node("Game").get_node("Background")
onready var room = preload("res://scenes/Spawn.tscn")
onready var wall_north = preload("res://scenes/wall_north.tscn")
onready var wall_south = preload("res://scenes/wall_south.tscn")
onready var wall_east = preload("res://scenes/wall_east.tscn")
onready var wall_west = preload("res://scenes/wall_west.tscn")
onready var player = get_node("Player")
onready var camera = get_node("Player/Camera2D")

#RNG
var RNG = RandomNumberGenerator.new()
var timeDict = OS.get_time()
var seconds = timeDict.second*OS.get_ticks_msec()

#Roomgeneration
#höhe und breite des room-arrays
var HEIGHT = 7
var WIDTH = 7


func _ready():

	justin.play()
	background.play()
	#Generierung des Levels. Als Parameter wird ein frisch generiertes Array durchgegeben, das das Layout angib
	var array = createArray()
	generate_level(array)
	generate_walls(array)
	
	#Spawnen des Spielers
	player.position.x = 448*4+224
	player.position.y = 256*4+128
	
	#Kamera auf Spieler setzen
	camera.current = true







func createArray():
	#Raumgenerierung
	
	#Erstellen eines 7x7 2D-Arrays namens Matrix, gefüllt mit 0
	var matrix = []
	for x in range(WIDTH):
	    matrix.append([])
	    matrix[x]=[]        
	    for y in range(HEIGHT):
	        matrix[x].append([])
	        matrix[x][y]=0
	print(matrix)
	print("^ ^ ^ UNEDITED MATRIX ^ ^ ^")
	
	#die Mitte des Arrays (3,3) ist der Anfang des Levels und somit ein Raum
	matrix[3][3] = 1
	
	RNG.seed = seconds
	var ANZ_RAEUME = 8
	var AKT_RAEUME = 1
	var chance = 1
	while AKT_RAEUME <= ANZ_RAEUME:
		#Array durchgehen
		for x in range (WIDTH):
			for y in range(HEIGHT):
				#Wenn ein Raum existiert mit Wahrscheinlichkeit von 25% einen Raum in der Nähe spawnen
				if matrix[x][y] == 1:
					#Für alle 4 Nachbarn:
					for i in range(4):
						chance = RNG.randi_range(1,5)
						if(chance == 1):
							match(i):
								1:
									#x+
									if!(x-1 < 0):
										if matrix[x-1][y] != 1:
											matrix[x-1][y] = 1
											AKT_RAEUME += 1
								2:
									#x-
									if!(x+1 > 6 ):
										if matrix[x+1][y] != 1:
											matrix[x+1][y] = 1
											AKT_RAEUME += 1
								3:
									#y+
									if!(y+1 > 6):
										if matrix[x][y+1] != 1:
											matrix[x][y+1] = 1
											AKT_RAEUME += 1
								4:
									#y-
									if!(y-1 < 0):
										if matrix[x][y-1] != 1:
											matrix[x][y-1] = 1
											AKT_RAEUME += 1
		#print(AKT_RAEUME)
		#print(AKT_RAEUME<=ANZ_RAEUME)
	print(matrix)
	print("^ ^ ^ EDITED MATRIX ^ ^ ^")
	return matrix




func generate_level(var matrix):
	#Array durchgehen
	for x in range (WIDTH):
		for y in range (HEIGHT):
			if(matrix[x][y] == 1):
				#einen Raum instanzieren und ins Projekt einfügen
				var instance = room.instance()
				add_child(instance)
				#nun die Koordinaten dieses Raumes an die Position im Array anpassen
				instance.position.x = 448*x
				instance.position.y = 256*y
	#Platzieren von benötoigten Wänden




func generate_walls(var matrix):
	#erneut array durchlaufen
	var values
	
	var instance
	for x in range (WIDTH):
		for y in range(HEIGHT):
			if (matrix[x][y] == 1):
				values = checkNeighbours(x,y,matrix)
				if(values[0] == 1):
					instance = wall_north.instance()
					add_child(instance)
					instance.position.x = x*448
					instance.position.y = y*256
				if(values[1] == 1):
					instance = wall_east.instance()
					add_child(instance)
					instance.position.x = x*448
					instance.position.y = y*256
				if(values[2] == 1):
					instance = wall_south.instance()
					add_child(instance)
					instance.position.x = x*448
					instance.position.y = y*256
				if(values[3] == 1):
					instance = wall_west.instance()
					add_child(instance)
					instance.position.x = x*448
					instance.position.y = y*256
			




func checkNeighbours(var x, var y, var matrix):
	var value_arr = []
	for x in range(4):
	    value_arr.append([])
	    value_arr[x]=[]
		
	
	if(y-1 >= 0 and matrix[x][y-1] == 0):
		value_arr[0] = 1
	else:
		value_arr[0] = 0
	if(x+1 <= WIDTH-1 and matrix[x+1][y] == 0):
		value_arr[1] = 1
	else:
		value_arr[1] = 0
	if(y+1 <= HEIGHT-1 and matrix[x][y+1] == 0):
		value_arr[2] = 1
	else:
		value_arr[2] = 0
	if(x-1 >= 0 and matrix[x-1][y] == 0):
		value_arr[3] = 1
	else:
		value_arr[3] = 0
	return value_arr



