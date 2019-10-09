extends KinematicBody

var forward_vec = Vector3(1, 0, 0)
var right_vec = Vector3(0, 0, 1)
var movement = Vector3()
var player_speed = 6

func _ready():
	pass

func _physics_process(delta):
	movement = Vector3()
	if(Input.is_action_pressed("move_forward")):
		movement += forward_vec
	if(Input.is_action_pressed("move_backward")):
		movement -= forward_vec
	if(Input.is_action_pressed("strafe_right")):
		movement += right_vec
	if(Input.is_action_pressed("strafe_left")):
		movement -= right_vec
	translate(movement.normalized() * player_speed * delta)
