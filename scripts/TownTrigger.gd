extends Area

const Unit = preload("res://prefabs/Unit.gd")

func _ready():
	connect("body_entered", self, "_on_body_enter")
	connect("body_exited", self, "_on_body_exit")
	pass

func _on_body_enter(body):
	print("Body " + body.name + " entered town " + get_parent().name)
	
	if body is Unit:
		if body.currentState == Unit.STATE.HARVEST:
			print("Body " + body.name + " is harvesting" + get_parent().name)
	pass

func _on_body_exit(body):
	print("Body " + body.name + " exited town " + get_parent().name)
	pass