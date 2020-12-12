extends Control

onready var parent = $"../"
export(PackedScene) var player
onready  var playerposition = $"../../PlayerPosition"
#props

onready var map_sizex = $VBoxContainer/TabContainer/World/VBoxContainer/HBoxContainer/mapsizex
onready var map_sizey = $VBoxContainer/TabContainer/World/VBoxContainer/HBoxContainer/mapsizey
#
onready var mwater_p = $VBoxContainer/TabContainer/World/VBoxContainer/HBoxContainer2/waterpoint
onready var mland_p =$VBoxContainer/TabContainer/World/VBoxContainer/HBoxContainer3/landpoint
onready var mtree_p = $"VBoxContainer/TabContainer/Tree's/VBoxContainer2/HBoxContainer/treepoint"
onready var mgrass_p = $VBoxContainer/TabContainer/Grass/VBoxContainer/HBoxContainer3/grasspoint
onready var mbush_p = $VBoxContainer/TabContainer/Bushes/VBoxContainer4/HBoxContainer5/bushpoint
onready var mrock_p = $VBoxContainer/TabContainer/Rocks/VBoxContainer6/HBoxContainer6/rockpoint
#var environment_p = Vector3(-0.1, 0.3,.04)
#from to till
onready var tree_from = $"VBoxContainer/TabContainer/Tree's/VBoxContainer2/HBoxContainer2/treefrom"
onready var tree_till = $"VBoxContainer/TabContainer/Tree's/VBoxContainer2/HBoxContainer2/treetill"
onready var grass_from = $VBoxContainer/TabContainer/Grass/VBoxContainer/HBoxContainer4/grassfrom
onready var grass_till = $VBoxContainer/TabContainer/Grass/VBoxContainer/HBoxContainer4/grasstill
onready var bush_from = $VBoxContainer/TabContainer/Bushes/VBoxContainer4/HBoxContainer2/bushfrom
onready var bush_till = $VBoxContainer/TabContainer/Bushes/VBoxContainer4/HBoxContainer2/bushtill
onready var rock_from = $VBoxContainer/TabContainer/Rocks/VBoxContainer6/HBoxContainer2/rockfrom
onready var rock_till = $VBoxContainer/TabContainer/Rocks/VBoxContainer6/HBoxContainer2/rocktill
# chances
onready var tree_chances = $"VBoxContainer/TabContainer/Tree's/VBoxContainer2/HBoxContainer3/treechance"
onready var grass_chances = $VBoxContainer/TabContainer/Grass/VBoxContainer/HBoxContainer5/grasschance
onready var bush_chances = $VBoxContainer/TabContainer/Bushes/VBoxContainer4/HBoxContainer6/bushchance
onready var rock_chances = $VBoxContainer/TabContainer/Rocks/VBoxContainer6/HBoxContainer7/rockchance


#steps
func _ready():
	map_sizex.text = String(parent.map_size.x)
	map_sizey.text  = String(parent.map_size.z)
	mwater_p.text = String(parent.water_p)
	mland_p.text = String(parent.land_p.y)
	mtree_p.text = String(parent.tree_p.y)
	mgrass_p.text = String(parent.grass_p.y)
	mbush_p.text = String(parent.bush_p.y)
	mrock_p.text = String(parent.rock_p.y)
	tree_from.text = String(parent.tree_from)
	tree_till.text = String(parent.tree_till)
	grass_from.text = String(parent.grass_from)
	grass_till.text = String(parent.grass_till)
	bush_from.text = String(parent.bush_from)
	bush_till.text = String(parent.bush_till)
	rock_from.text = String(parent.rock_from)
	rock_till.text = String(parent.rock_till)
	tree_chances.text = str(parent.tree_chances)
	grass_chances.text = str(parent.grass_chances)
	bush_chances.text = str(parent.bush_chances)
	rock_chances.text = str(parent.rock_chances)
#	$VBoxContainer2/Ntree.text = "No of Tree's: " + str(parent.t.get_child_count())
#	$VBoxContainer2/Ngrass.text = "No of Tree's: " + str(parent.g.get_child_count())
#	$VBoxContainer2/Nbush.text = "No of Tree's: " + str(parent.b.get_child_count())
#	$VBoxContainer2/Nrock.text = "No of Tree's: " + str(parent.r.get_child_count())

#	$VBoxContainer/TabContainer/World/VBoxContainer/HBoxContainer/LineEdit.text = "pendora"
#	print("here have some text"+$VBoxContainer/TabContainer/World/VBoxContainer/HBoxContainer/LineEdit.text)

func _on_ButtonWorld_pressed():
	parent.map_size.x = int(map_sizex.text)
	parent.map_size.z = int(map_sizey.text)
	parent.water_p = float(mwater_p.text)
	parent.land_p.x = parent.water_p
	parent.land_p.y = float(mland_p.text)
	parent.noise_and_stuff()
	parent.make_land_map()


func _on_ButtonTrees_pressed():
	parent.tree_p.x = float(mwater_p.text)
	parent.tree_p.y = float(mtree_p.text)
	parent.tree_from = int(tree_from.text)
	parent.tree_till = int(tree_till.text)
	parent.tree_chances = int(tree_chances.text)
	parent.plant_trees()
	$VBoxContainer2/Ntree.text = "No of Trees: " + str(parent.t.get_child_count())

func _on_ButtonGrass_pressed():
	parent.grass_p.x = float(mtree_p.text)
	parent.grass_p.y = float(mgrass_p.text)
	parent.grass_from = int(grass_from.text)
	parent.grass_till = int(grass_till.text)
	parent.grass_chances = int(grass_chances.text)
	parent.plant_grasses()
	$VBoxContainer2/Ngrass.text = "No of Grass: " + str(parent.g.get_child_count())


func _on_ButtonBushes_pressed():
	parent.bush_p.x = float(mgrass_p.text)
	parent.bush_p.y = float(mbush_p.text)
	parent.bush_from = int(bush_from.text)
	parent.bush_till = int(rock_till.text)
	parent.bush_chances = int(bush_chances.text)
	parent.plant_bushes()
	$VBoxContainer2/Nbush.text = "No of bushes: " + str(parent.b.get_child_count())
	

func _on_ButtonRocks_pressed():
	parent.rock_p.x = float(mbush_p.text)
	parent.rock_p.y = float(mrock_p.text)
	parent.rock_from = int(rock_from.text)
	parent.rock_till = int(rock_till.text)
	parent.rock_chances = int(rock_chances.text)
	parent.plant_rocks()
	$VBoxContainer2/Nrock.text = "No of Rocks: " + str(parent.r.get_child_count())


func _on_WorldCamera_pressed():
	var childs = playerposition.get_children()
	for child in childs:
		child.queue_free()
	$"../../Spatial/Camera".current = true


func _on_Player_pressed():
	var p = player.instance()
	playerposition.add_child(p)
	$"../../Spatial/Camera".current = false
	p.camera.current = true


func _on_GenerateWorld_pressed():
	parent.map_size.x = int(map_sizex.text)
	parent.map_size.z = int(map_sizey.text)
	parent.water_p = float(mwater_p.text)
	parent.land_p.x = parent.water_p
	parent.land_p.y = float(mland_p.text)
	parent.tree_p.x = float(mwater_p.text)
	parent.tree_p.y = float(mtree_p.text)
	parent.tree_from = int(tree_from.text)
	parent.tree_till = int(tree_till.text)
	parent.grass_p.x = float(parent.tree_p.y)
	parent.grass_p.y = float(mgrass_p.text)
#	print(parent.grass_p.x,parent.grass_p.y)
	parent.grass_from = int(grass_from.text)
	parent.grass_till = int(grass_till.text)
	parent.bush_p.x = float(parent.grass_p.y)
	parent.bush_p.y = float(mbush_p.text)
	parent.bush_from = int(bush_from.text)
	parent.bush_till = int(rock_till.text)
	parent.rock_p.x = float(parent.bush_p.y)
	parent.rock_p.y = float(mrock_p.text)
	parent.rock_from = int(rock_from.text)
	parent.rock_till = int(rock_till.text)
	parent.tree_chances = int(tree_chances.text)
	parent.grass_chances = int(grass_chances.text)
	parent.bush_chances = int(bush_chances.text)
	parent.rock_chances = int(rock_chances.text)
	parent.create_world()
	
	$VBoxContainer2/Ntree.text = "No of Trees: " + str(parent.t.get_child_count())
	$VBoxContainer2/Ngrass.text = "No of Grass: " + str(parent.g.get_child_count())
	$VBoxContainer2/Nbush.text = "No of Bushes: " + str(parent.b.get_child_count())
	$VBoxContainer2/Nrock.text = "No of Rocks: " + str(parent.r.get_child_count())





func _on_ButtonAnimals_pressed():
	parent.drop_anims()



