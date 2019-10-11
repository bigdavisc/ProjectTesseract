extends KinematicBody

const BASE_SPEED = 30
const UPPER_VIEW_LIMIT = 50
const LOWER_VIEW_LIMIT = 50
const MOUSE_SENSITIVITY = 0.1

var mouse_sensetivity = 0.1  # We might want to move this into a settings file
var gravity = 9.8  #Will be changed by plane Player exists on

var input_velocity = Vector2()

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

func _process(delta):
	if Input.is_action_just_pressed("ui_cancel"):
		if Input.get_mouse_mode() == Input.MOUSE_MODE_VISIBLE:
			Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
		else:
			Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)

func _physics_process(delta):
	process_input()
	process_movement(delta)
	
func process_input():
	input_velocity = Vector2()
	if(Input.is_action_pressed("move_forward")):
		input_velocity.y += 1
	if(Input.is_action_pressed("move_backward")):
		input_velocity.y -= 1
	if(Input.is_action_pressed("strafe_right")):
		input_velocity.x += 1
	if(Input.is_action_pressed("strafe_left")):
		input_velocity.x -= 1
	input_velocity = input_velocity.normalized()

func process_movement(delta):
	var camera_transform = $Camera.get_global_transform()
	# Horizontal movement
	var horizontal_velocity = Vector3()
	horizontal_velocity += camera_transform.basis.x * input_velocity.x
	horizontal_velocity += -camera_transform.basis.z * input_velocity.y
	horizontal_velocity.y = 0
	horizontal_velocity = horizontal_velocity.normalized()
	
	var target = horizontal_velocity * BASE_SPEED
	var accel
	if horizontal_velocity.dot(horizontal_velocity) > 0:
		accel = 20
	else:
		accel = 40
	horizontal_velocity = horizontal_velocity.linear_interpolate(target, accel * delta)
	
	# Vertical movement - Noah do your stuff here
	var vertical_velocity = 0
	#vertical_velocity -= gravity #This will be disabled/reset while on a surface
	#movement.y += vertical_velocity
	
	var velocity = Vector3(horizontal_velocity.x, vertical_velocity, horizontal_velocity.z)
	velocity = move_and_slide(velocity, Vector3(0, 1, 0), 0.05, 4, deg2rad(40))

func _input(event):
	if event is InputEventMouseMotion and Input.get_mouse_mode() == Input.MOUSE_MODE_CAPTURED:
		$Camera.rotate_x(deg2rad(event.relative.y * mouse_sensetivity))
		$Camera.rotation.x = clamp($Camera.rotation.x, deg2rad(-LOWER_VIEW_LIMIT), deg2rad(UPPER_VIEW_LIMIT))
		rotate_y(deg2rad(event.relative.x * mouse_sensetivity * -1))