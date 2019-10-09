extends KinematicBody

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var forward_vec = Vector3(1,0,0)
var right_vec = Vector3(0,0,1)
var player_speed = 4
# Called when the node enters the scene tree for the first time.
func _ready():
	pass

func _physics_process(delta):
	if(Input.is_action_pressed("ui_up")):
		translate(forward_vec*player_speed*delta)
	if(Input.is_action_pressed("ui_down")):
		translate(-forward_vec*player_speed*delta)
	if(Input.is_action_pressed("ui_left")):
		translate(-right_vec*player_speed*delta)
	if(Input.is_action_pressed("ui_right")):
		translate(right_vec*player_speed*delta)
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
