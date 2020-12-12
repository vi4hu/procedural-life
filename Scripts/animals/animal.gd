extends KinematicBody

class_name animals

#ondeady 
onready var root = $"../../"
onready var Armature = $Armature
onready var camera = $Armature/Camera
#onready var pausemenu = get_node("/root/"+root.lname+"/UI/PauseLabel")
onready var animation_player = $AnimationPlayer
onready var ray = $Armature/Camera/InteractableRayCast

# camera vars
export var mouse_sensitivity = 0.3
var camera_x_rotation = 0

# values
var life_span := 0.0
#var health := 0
var hunger := 0.0
var thirst := 0.0
var personal := {"gender":{"M":0, "F":0},"species":{"triceratops":0, "parasourolophus":1}}
var habit := {"prefer":{"left":0,"right":1},"time":{"day":0,"night":1}}
var gender := null
var species := null
var maxstrength := 0

# physical vars
var angle := 0.0
var speed := 0

#counters
var hunger_counter := 0.0
var thirst_counter := 0.0

# ready 
func _ready():
#	print(habit["prefer"]["right"])
	pass

func born(ls,hun,th,gen,sep,hunc,thc,sp,ms):
	self.life_span = ls
#	self.health = heal
	self.hunger = hun
	self.thirst = th
	self.gender = gen
	self.species = sep
	self.hunger_counter = hunc
	self.thirst_counter = thc
	self.speed = sp
	self.maxstrength = ms

func random_walk_angle():
	angle = 0.0
	var chance = randi() % 5
	match chance:
		0:
			angle = 0.0
		1: 
			angle = 45.0
		2:
			angle = -45.0
		3: 
			angle = 90.0
		4:
			angle = -90.0
		
	return angle

func different_walk_angle():
	angle = 0.0
	var chance = randi() % 5 + 1
	match chance:
		1: 
			angle = 45.0
		2:
			angle = -45.0
		3: 
			angle = 90.0
		4:
			angle = -90.0
		
	return angle
	
# counter value
var hvalue := 0.0
var tvalue := 0.0

func decrease_life_remain(delta):
	life_span -= delta
	if life_span <= 0:
		death()



func decrease_my_hunger(delta):
	hvalue += delta
	if hvalue >= self.hunger_counter:
		self.hunger -= 1.0
		hvalue = 0.0
	if self.hunger <= 0.0:
		death()
	

func increase_my_hunger(value):
	hunger += value


func decrease_my_thirst(delta):
	tvalue += delta
	if tvalue >= self.thirst_counter:
		self.thirst -= 1.0
		tvalue = 0.0
	if self.thirst <= 0.0:
		death()


func increase_my_thirst(value):
	thirst += value


func _process(delta):
	if Input.is_action_just_pressed("esc"):
#		print(Input.get_mouse_mode())
#		pausemenu.set_visible(true)
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
#		print(Input.get_mouse_mode()-1)

	elif Input.get_mouse_mode() == 0 and Input.is_mouse_button_pressed(2):
#		pausemenu.set_visible(false)
		Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)


#death
func death():
	queue_free()
