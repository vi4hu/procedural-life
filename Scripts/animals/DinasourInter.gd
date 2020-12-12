extends Interactable

onready var parent = get_node("../../../..")
onready var player = get_node("/root/Main/PlayerPosition")
onready var ui = get_node("../../../../AnimUI")

func get_interaction_text():
	return "coming soon"

func interact():
	ui.show()
	
	
	
func back_to_normal():
	ui.hide()

func get_resource_name():
	return "Dinasour"
