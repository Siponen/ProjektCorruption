extends Node
var parent = {}
var task = {}

func _ready():
	parent = get_parent()
	pass

func _physics_process(delta):
	if task != null:
		task.physicsTick(delta)
	pass

func _process(delta):
	if task != null:
		task.tick(delta)
	pass