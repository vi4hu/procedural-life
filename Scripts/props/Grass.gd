extends Spatial

export(float) var decount
onready var base = $Grass
onready var sound = $Sound
var _eaten = false
var end_by = null
func _ready():
	pass
	base.scale = Vector3(0.1,0.1,0.1)
#	print(base.scale)
	
	

func eated():
	base.scale -= Vector3(decount,decount,decount)
	if base.scale <= Vector3(0,0,0):
		dead()

func grow():
	if base.scale < Vector3(1.0,1.0,1.0):
		base.scale += Vector3(decount,decount,decount)
	
func dead():
	queue_free()


#func _on_Area_body_entered(body):
#	if body.is_in_group("Player"):
#		sound.play()
