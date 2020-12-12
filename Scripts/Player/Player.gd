extends KinematicBody

export var Speed = 5
export var Gravity = 0.98
export var Jump = 15
export var mouse_sensitivity = 0.3

var footstep_rate = 0.5
var cur_step_time = 0.0
var dir = Vector3.ZERO
var camera_x_rotation = 0
var velocity = Vector3.ZERO
var acceleration = 6

onready var root = $"../"
onready var head = $Head
onready var camera = $Head/Camera
#onready var pausemenu = get_node("/root/"+root.lname+"/UI/PauseLabel")
onready var animation_player = $AnimationPlayer
onready var ray = $Head/Camera/InteractableRaycast


var active = true
var dead = false
signal dead

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	
func _input(event):
	if not active:
		return
	if dead:
		return
		
	if event is InputEventMouseMotion:
		head.rotate_y(deg2rad(-event.relative.x * mouse_sensitivity))
		var x_delta = event.relative.y * mouse_sensitivity
		if camera_x_rotation + x_delta > -90 and camera_x_rotation + x_delta < 90:
			camera.rotate_x(deg2rad(-x_delta))
			camera_x_rotation += x_delta
			
func _process(delta):
	if Input.is_action_just_pressed("esc"):
#		print(Input.get_mouse_mode())
#		pausemenu.set_visible(true)
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
#		print(Input.get_mouse_mode()-1)

	elif Input.get_mouse_mode() == 0 and Input.is_mouse_button_pressed(2):
#		pausemenu.set_visible(false)
		Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

func _physics_process(delta):
	var head_basis = head.get_global_transform().basis
	var _forward = Input.is_action_pressed("forward")
	var _backward = Input.is_action_pressed("backward")
	var _left = Input.is_action_pressed("left")
	var _right = Input.is_action_pressed("right")
	var _jump = Input.is_action_pressed("jump")
	
	
	dir = Vector3.ZERO
	
	if not active:
		return
	if dead:
		return
		
	if _forward:
		dir -=  head_basis.z
	elif _backward:
		dir += head_basis.z
	
	if _left:
		dir -= head_basis.x
	elif _right:
		dir += head_basis.x
		
	if _jump:
		if is_on_floor():
			velocity.y = Jump
	
	dir = dir.normalized()
	
#	if dir != Vector3.ZERO:
#		cur_step_time += delta
#		animation_player.play("walkShake")
#		if cur_step_time >= footstep_rate:
#			cur_step_time = 0.0
#			$WalkingSounds.play()
#	else:
#		animation_player.play("free")
			
	velocity = velocity.linear_interpolate(dir * Speed, acceleration * delta)
	
	apply_gravity()
	
	velocity = move_and_slide(velocity, Vector3.UP)
	
	
		
func apply_gravity():
	if not is_on_floor():
		velocity.y -= Gravity


func dead():
	dead = true
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	animation_player.play("dead")
	
	
