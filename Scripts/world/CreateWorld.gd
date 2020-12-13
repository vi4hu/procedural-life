extends Node

var noise
export (NodePath) onready var groundtiles = $"../Groundtiles"
export (NodePath) onready var bordertiles = $"../BorderTiles"

#based land
export var map_size = Vector3(20,1,20)

#breaking points
export var water_p = -0.3
export var land_p = Vector2(-0.3,-0.23)
export var tree_p = Vector2(-0.23, 0.50)
export var grass_p = Vector2(0.30, 0.55)
export var bush_p = Vector2(0.40, 0.47)
export var rock_p = Vector2(0.48, 0.5)
export var road_p = Vector2(0.3,.05)
export var environment_p = Vector3(-0.1, 0.3,.04)

#props holders path
export onready var l_w = $"../LandandWater"
export onready var a = $"../Dianasours"
export onready var t = $"../Trees"
export onready var g = $"../Grass"
export onready var b = $"../Bushes"
export onready var r = $"../Rocks"

#dirs
export(String, DIR) var buildingblocks_dir
export(String, DIR) var anims_dir
export(String, DIR) var trees_dir
export(String, DIR) var grass_dir
export(String, DIR) var rocks_dir

#from to till
export(int) var tree_from = 2
export(int) var tree_till = 2
export(int) var grass_from = 2
export(int) var grass_till = 1
export(int) var bush_from = 1
export(int) var bush_till = 1
export(int) var rock_from = 0
export(int) var rock_till = 1

#chance
export(int) var anim_chances = 5
export(int) var tree_chances = 5
export(int) var grass_chances = 40
export(int) var bush_chances = 20
export(int) var rock_chances = 50

var anims = []
var trees = []
var grass = []
var rocks = []
var blocks = []

func _ready():
#	tree_p = Vector3(water_p, tree_p.y)
	noise_and_stuff()
	create_world()


func create_world():
	free_all_the_animals()
	noise_and_stuff()
	dir_buildingblocks(buildingblocks_dir)
	dir_anims(anims_dir)
	dir_grass(grass_dir)
	dir_trees(trees_dir)
	dir_rocks(rocks_dir)
	make_land_map()
	make_boundies()
	plant_trees()
	plant_grasses()
	plant_bushes()
	plant_rocks()
	
func noise_and_stuff():
	randomize()
	noise = OpenSimplexNoise.new()
	noise.seed = randi()
	noise.persistence = 0.7
	noise.octaves = 1.0
	noise.period = 12

func make_land_map():
	groundtiles.clear()
	free_all_the_water()
	for x in map_size.x:
		for y in map_size.y:
			for z in map_size.z:
				var n = noise.get_noise_2d(x,z)
				if n < water_p:
#					groundtiles.set_cell_item(x,y,z,2)
					var water_load = load(buildingblocks_dir + "/"+ blocks[1])
					var water_ins = (water_load).instance()
					l_w.add_child(water_ins)
					var pos = Vector3(x*2+1,(y+1),z*2+1)
					water_ins.set_translation(pos)
				elif n > land_p.x and n < land_p.y:
					groundtiles.set_cell_item(x,y,z,3)
#					var sand_load = load(buildingblocks_dir + "/"+ blocks[1])
#					var sand_ins = (sand_load).instance()
#					l_w.add_child(sand_ins)
#					var pos = Vector3(x*2,(y+1),z*2)
#					sand_ins.set_translation(pos)
				else:
					groundtiles.set_cell_item(x,y,z,0)
#					var land_load = load(buildingblocks_dir + "/"+ blocks[2])
#					var land_ins = (land_load).instance()
#					l_w.add_child(land_ins)
#					var pos = Vector3(x*2,(y+1),z*2)
#					land_ins.set_translation(pos)


func make_boundies():
	for x in map_size.x:
		for y in map_size.y:
			for z in map_size.z:
				if x > (map_size.x  - 2):
					bordertiles.set_cell_item(x,y,z,8,0)
				elif x < 1:
					bordertiles.set_cell_item(x,y,z,7,0)
				if z > (map_size.z - 2):
					bordertiles.set_cell_item(x,y,z,9,0)
				elif z < 1:
					bordertiles.set_cell_item(x,y,z,4,0)


func plant_trees():
	free_every_tree()
	for x in map_size.x:
		for y in map_size.y:
			for z in map_size.z:
				if x < (map_size.x  - 4) and x > 2:
					var n = noise.get_noise_2d(x,z)
					if  n > tree_p.x and n < tree_p.y:
						var chance = randi() % 100
						if chance < tree_chances:
							if tree_from > trees.size() or tree_till == 0:
								break
							var tree_load = load(trees_dir + "/"+ trees[randi()%tree_till + tree_from])
							var tree_ins = (tree_load).instance()
							t.add_child(tree_ins)
							var pos = Vector3(x*2,(y+1),z*2)
							tree_ins.set_translation(pos)


func plant_grasses():
	free_every_grass()
	for x in map_size.x:
		for y in map_size.y:
			for z in map_size.z:
				if x < (map_size.x  - 4) and x > 2:
					var n = noise.get_noise_2d(x,z)
					if  n > grass_p.x and n < grass_p.y:
						var chance = randi()%100
						if chance < grass_chances:
							if grass_from > grass.size() or grass_till == 0:
								break
							var grass_load = load(grass_dir + "/"+ grass[randi()%grass_till + grass_from])
							var grass_ins = (grass_load).instance()
							g.add_child(grass_ins)
							var pos = Vector3(x*2,(y+1.25),z*2)
							grass_ins.set_translation(pos)


func plant_bushes():
	free_every_bush()
	for x in map_size.x:
		for y in map_size.y:
			for z in map_size.z:
				if x < (map_size.x  - 4) and x > 2:
					var n = noise.get_noise_2d(x,z)
					if  n > bush_p.x and n < bush_p.y:
						var chance = randi()%100
						if chance < bush_chances:
							if bush_from > grass.size() or bush_till == 0:
								break
							var bush_load = load(grass_dir + "/"+ grass[randi()%bush_till + bush_from])
							var bush_ins = (bush_load).instance()
							b.add_child(bush_ins)
							var pos = Vector3(x*2,(y+1.08),z*2)
							bush_ins.set_translation(pos)


func plant_rocks():
	free_every_rock()
	for x in map_size.x:
		for y in map_size.y:
			for z in map_size.z:
				if x < (map_size.x  - 4) and x > 2:
					var n = noise.get_noise_2d(x,z)
					if  n > rock_p.x and n < rock_p.y:
						var chance = randi()%100
						if chance < rock_chances:
							if rock_from > rocks.size() or rock_till == 0:
								break
							var rocks_load = load(rocks_dir + "/"+ rocks[randi()%rock_till + rock_from])
							var rocks_ins = (rocks_load).instance()
							r.add_child(rocks_ins)
							var pos = Vector3(x*2,(y+1.3),z*2)
							rocks_ins.set_translation(pos)


func drop_anims():
	free_all_the_animals()
	for x in map_size.x:
		for y in map_size.y:
			for z in map_size.z:
				if x < (map_size.x  - 4) and x > 2:
					var n = noise.get_noise_2d(x,z)
					if  n > grass_p.x and n < grass_p.y:
						var chance = randi()%100
						if chance < anim_chances:
							var anims_load = load(anims_dir + "/"+ anims[0])
							var anims_ins = (anims_load).instance()
							a.add_child(anims_ins)
							var pos = Vector3(x*2,(y+1.3),z*2)
							anims_ins.set_translation(pos)


func dir_buildingblocks(path):
	var dir = Directory.new()
	if dir.open(path) == OK:
		dir.list_dir_begin()
		var file_name = dir.get_next()
		while file_name != "":
			if dir.current_is_dir():
				print("Found directory: " + file_name)
			else:
				blocks.append(file_name)
#				print("Found file: " + file_name)
			file_name = dir.get_next()
	else:
		print("An error occurred when trying to access the path.")


func dir_trees(path):
	var dir = Directory.new()
	if dir.open(path) == OK:
		dir.list_dir_begin()
		var file_name = dir.get_next()
		while file_name != "":
			if dir.current_is_dir():
				print("Found directory: " + file_name)
			else:
				trees.append(file_name)
#				print("Found file: " + file_name)
			file_name = dir.get_next()
	else:
		print("An error occurred when trying to access the path.")
#	print("items")
#	print("item"+trees[0])


func dir_grass(path):
	var dir = Directory.new()
	if dir.open(path) == OK:
		dir.list_dir_begin()
		var file_name = dir.get_next()
		while file_name != "":
			if dir.current_is_dir():
				print("Found directory: " + file_name)
			else:
				grass.append(file_name)
				print("Found file: " + file_name)
			file_name = dir.get_next()
	else:
		print("An error occurred when trying to access the path.")
#	print("items")
#	print("item"+grass[0])


func dir_rocks(path):
	var dir = Directory.new()
	if dir.open(path) == OK:
		dir.list_dir_begin()
		var file_name = dir.get_next()
		while file_name != "":
			if dir.current_is_dir():
				print("Found directory: " + file_name)
			else:
				rocks.append(file_name)
#				print("Found file: " + file_name)
			file_name = dir.get_next()
	else:
		print("An error occurred when trying to access the path.")
#	print("items")
#	print("item"+rocks[0])


func dir_anims(path):
	var dir = Directory.new()
	if dir.open(path) == OK:
		dir.list_dir_begin()
		var file_name = dir.get_next()
		while file_name != "":
			if dir.current_is_dir():
				print("Found directory: " + file_name)
			else:
				anims.append(file_name)
				print("Found file: " + file_name)
			file_name = dir.get_next()
	else:
		print("An error occurred when trying to access the path.")
	

func free_every_tree():
	var childs = t.get_children()
	for child in childs:
		child.queue_free()


func free_every_grass():
	var childs = g.get_children()
	for child in childs:
		child.queue_free()


func free_every_bush():
	var childs = b.get_children()
	for child in childs:
		child.queue_free()


func free_every_rock():
	var childs = r.get_children()
	for child in childs:
		child.queue_free()

func free_all_the_water():
	var childs = l_w.get_children()
	for child in childs:
		child.queue_free()

func free_all_the_animals():
	var childs = a.get_children()
	for child in childs:
		child.queue_free()
