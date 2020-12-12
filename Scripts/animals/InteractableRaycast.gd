extends RayCast

var current_collider
onready var main = $"../../.."
#onready var root = $"../../../../"
#onready var interaction_label = get_node("/root/Main/CreateWorld/UI/InteractionLabel")
#onready var its_a = get_node("/root/Main/CreateWorld/UI/ItsA")


#func _ready():
#	set_interaction_test("")
#	set_resource_name("")


func _process(delta):
	var collider = get_collider()
	
			
	if is_colliding() and collider is Interactable:
		if current_collider !=collider:
			current_collider = collider
			collider.interact()
			collider.end_by(main)
#			set_interaction_test(collider.get_interaction_text())
#			set_resource_name(collider.get_resource_name())
		if collider.is_in_group("wall"):
				main.change_dir(delta)
		
#		if Input.is_action_pressed("interact"):
#			collider.interact()
#		else:
#			collider.back_to_normal()
#			set_interaction_test(collider.get_interaction_text())
#			set_resource_name(collider.get_resource_name())
				
	elif current_collider:
		current_collider = null
#		set_interaction_test("")
#		set_resource_name("")


#func set_interaction_test(text):
#	if !text:
#		interaction_label.set_text("")
#		interaction_label.set_visible(false)
#	else:
#		var interact_key = OS.get_scancode_string(InputMap.get_action_list("interact")[0].scancode)
#		interaction_label.set_text("Presss %s to %s" % [interact_key, text])
#		interaction_label.set_visible(true)

#func set_resource_name(text):
#	if !text:
#		its_a.set_text("")
#		its_a.set_visible(false)
#	else:
#		its_a.set_text(text)
#		its_a.set_visible(true)
