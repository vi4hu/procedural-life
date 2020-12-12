extends animals


export var Gravity = 0.98
export var Jump = 15

var footstep_rate = 5
var cur_step_time = 0.0
var dir = Vector3.ZERO
var velocity = Vector3.ZERO
var acceleration = 6
var target = null
var sp = 100
var idel = false
var search = true
var space_state

func _ready():
#	born(ls,hun,th,gen,hunc,thc,sp,ms)
	space_state = get_world().direct_space_state
	born(100,20,30,"M","triceratops",2,2,1,10)

func _process(delta):
	decrease_my_hunger(delta)
	decrease_my_thirst(delta)
	decrease_life_remain(delta)


func _input(event):
	if camera.current:
		if event is InputEventMouseMotion:
			self.rotate_y(deg2rad(-event.relative.x * mouse_sensitivity))
			var x_delta = event.relative.y * mouse_sensitivity
			if camera_x_rotation + x_delta > -90 and camera_x_rotation + x_delta < 90:
				camera.rotate_x(deg2rad(-x_delta))
				camera_x_rotation += x_delta


func change_dir(delta):
	self.rotate_y(different_walk_angle())
#	print("change dir")

func rotate_itself():
	dir = Vector3.ZERO
	dir = (global_transform.origin).normalized()
	var angle = rad2deg(dir.angle_to(target.global_transform.origin))
	self.rotate_y(angle)
	
	
func move_to_tar(delta):
#	var Armature_basis = Armature.get_global_transform().basis
	dir = Vector3.ZERO
#	print("first")
	if target:# and (abs(target.transform.origin.x) - abs(transform.origin.x)) > 2:
#		print("second")
#		look_at(-target.global_transform.origin, Vector3.UP)
		dir = (target.global_transform.origin - global_transform.origin).normalized()
		look_at(dir,Vector3.UP)
#		self.rotate_y(rad2deg(dir.angle_to(target.transform.origin)))

#	print((abs(target.global_transform.origin.x) - abs(global_transform.origin.x)))
		var x = abs((target.global_transform.origin.x - global_transform.origin.x))
		var z = abs((target.global_transform.origin.z - global_transform.origin.z))
		if x > 2 or z > 2:
			move_and_slide(dir * sp * delta, Vector3.UP)
		else:
			idel = true
	apply_gravity()


func search(delta):
	var Armature_basis = Armature.get_global_transform().basis
	dir = Vector3.ZERO
	dir += Armature_basis.z
	
	dir = dir.normalized()
	
	if dir != Vector3.ZERO:
		cur_step_time += delta
		if cur_step_time >= footstep_rate:
			cur_step_time = 0.0
			self.rotate_y(random_walk_angle())
#	else:
#		animation_player.play("free")
			
	velocity = velocity.linear_interpolate(dir * speed, acceleration * delta)
	apply_gravity()
#	print("yes")
	velocity = move_and_slide(velocity, Vector3.UP)
	
		
func apply_gravity():
	if not is_on_floor():
		velocity.y -= Gravity


func _on_Area_body_entered(body):
#	print("detected",hunger,thirst)
	if not target:
		pass
		if hunger <= thirst:
			if body.is_in_group("grass"):
	#			print("grass")
				search = false
				target = body
		elif thirst <= hunger:
			if body.is_in_group("water"):
	#			print("water")
				search = false
				target = body
		else:
			search = true
			target = null
func get_done(body):
	if body == target:
		target = null
		search = true
