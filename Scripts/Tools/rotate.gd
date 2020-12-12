extends Spatial

onready var createworld = $"../CreateWorld"
onready var cam = $Camera


func _ready():
	pass


func _process(delta):
	translation.x = createworld.map_size.x
	translation.z = createworld.map_size.z
	cam.translation.x = -max(translation.x ,translation.z)
	rotation += Vector3(0,delta,0)
#
