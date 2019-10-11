extends Area

export var newPos = Vector3()

func _ready():
	pass

func _on_Portal_body_entered(body):
	if body.is_in_group("Player"):
		body.translation = newPos