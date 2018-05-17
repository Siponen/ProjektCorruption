extends Area

# class member variables go here, for example:
# var a = 2
# var b = "textvar"
const Unit = preload("res://prefabs/Unit.gd")
func _ready():
	connect("body_entered", self, "_on_body_enter")
	connect("body_exited", self, "_on_body_exit")
	pass
	
func _on_body_enter(body):
	if body is Unit:
		if body.unitOwner == "Player" and body.currentState == Unit.STATE.HARVEST_RETURN:
			var player = $"/root/Player"
			player.numFollowers += 1
	pass
	
func _on_body_exit(body):
	pass