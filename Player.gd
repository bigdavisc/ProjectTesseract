extends KinematicBody

var player_speed = 8
var mouse_sensetivity = 0.1
var upper_view_limit = 50
var lower_view_limit = 50
var gravity = 9.8  #Will be changed by plane Player exists on
var vertical_velocity = 0

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

func _process(delta):
	if Input.is_action_just_pressed("ui_cancel"):
		if Input.get_mouse_mode() == Input.MOUSE_MODE_VISIBLE:
			Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
		else:
			Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
			
func _physics_process(delta):
	var movement = Vector3()
	var cam_transform = $Camera.get_global_transform()
	
	var input = Vector2()
	if(Input.is_action_pressed("move_forward")):
		input.y += 1
	if(Input.is_action_pressed("move_backward")):
		input.y -= 1
	if(Input.is_action_pressed("strafe_right")):
		input.x += 1
	if(Input.is_action_pressed("strafe_left")):
		input.x -= 1
	input = input.normalized()
	
	movement += cam_transform.basis.x * input.x
	movement += -cam_transform.basis.z * input.y
	movement.y = 0
	movement = movement.normalized()
	#vertical_velocity -= gravity #This will be disabled/reset while on a surface
	#movement.y += vertical_velocity
	move_and_collide(movement * player_speed * delta)

func _input(event):
	if event is InputEventMouseMotion and Input.get_mouse_mode() == Input.MOUSE_MODE_CAPTURED:
		$Camera.rotate_x(deg2rad(event.relative.y * mouse_sensetivity))
		$Camera.rotation.x = clamp($Camera.rotation.x, deg2rad(-lower_view_limit), deg2rad(upper_view_limit))
		rotate_y(deg2rad(event.relative.x * mouse_sensetivity * -1))