extends Node

class_name Interactable

func get_interaction_text():
	return "Interact"


func interact():
	print("interacted with %s" % name)


func back_to_normal():
	print("I'm back to normal.")

func get_resource_name():
	return "Resource"
