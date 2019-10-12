extends Area

export var connectedPortal = "PortalName"
var used = false

func _ready():
	pass

func _on_Portal_body_entered(body):
	if not used and body.is_in_group("Player"):
		print("Entered portal")
		for portal in get_tree().get_nodes_in_group("Portal"):
			print("Checking portal: " + portal.get_name())
			if portal.get_name() == connectedPortal:
				body.translation = portal.translation
				portal.used = true

func _on_Portal_body_exited(body):
	used = false
