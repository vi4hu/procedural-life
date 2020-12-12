extends Interactable

onready var parent = get_node("../..")

#func get_interaction_text():
#	return "eat grass"

#func interact():
#	print("interacted with %s" % name)
#	parent._eaten = true


func back_to_normal():
#	print("backtonormal")
#	parent._eaten = false
	pass


func get_resource_name():
	return "Tree"
