extends Node2D

onready var justin=get_tree().get_root().get_node("Game").get_node("ICEDOUT")
onready var background=get_tree().get_root().get_node("Game").get_node("Background")


var RNG = RandomNumberGenerator.new()

var timeDict = OS.get_time()
var seconds = timeDict.second*OS.get_ticks_msec()


func _ready():
	justin.play()
	background.play()
	#Raumgenerierung
	#Raumbreite und Höhe
	var width = 7
	var height = 7
	
	#Erstellen eines 7x7 2D-Arrays namens Matrix, gefüllt mit 0
	var matrix = []
	for x in range(width):
	    matrix.append([])
	    matrix[x]=[]        
	    for y in range(height):
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
		for x in range (width):
			for y in range(height):
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
		print(AKT_RAEUME)
		print(AKT_RAEUME<=ANZ_RAEUME)
	print(matrix)
	print("^ ^ ^ EDITED MATRIX ^ ^ ^")
	pass

func _process(delta):
	
	pass

