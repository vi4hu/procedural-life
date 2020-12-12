extends Control

onready var parent = get_parent()

func _process(delta):
	$VBoxContainer/Life.text ="Remaining Life: "+ str(parent.life_span)
	$VBoxContainer/Hunger.text ="Hunger: " + str(parent.hunger)
	$VBoxContainer/Thirst.text ="Thirst: " + str(parent.thirst)
	$VBoxContainer/Species.text ="Species: " + str(parent.species)
	$VBoxContainer/Gender.text ="Gender: " + str(parent.gender)
