extends Area

export var connectedPortal = "PortalName"

var used = false

func _ready():
	$RotationVisualizer.visible = false

func _on_Portal_body_entered(body):
	if not used and body.is_in_group("Player"):
		for portal in get_tree().get_nodes_in_group("Portal"):
			if portal.get_name() == connectedPortal:
				body.translation = portal.get_global_transform().origin
				body.rotation.y = portal.get_global_transform().basis.get_euler().y
				portal.used = true
				return

func _on_Portal_body_exited(body):
	used = false
