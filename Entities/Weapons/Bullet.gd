extends Area

var SPEED = 50

func _physics_process(delta):
	var movement = global_transform.basis.z.normalized() * SPEED
	global_translate(movement * delta)