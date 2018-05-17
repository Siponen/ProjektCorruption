extends KinematicBody

var unitName = ""
var unitOwner = ""

var abilities = []
var currentTask = {}

var isMoving = false

var velocity = Vector3(0,0,0)
var destination = Vector3(0,0,0)

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	pass
	
func _physics_process(delta):
	if(isMoving):
		var margin = 0.3
		if translation.x >= destination.x-margin and translation.x <= destination.x+margin and translation.z >= destination.z-margin and translation.z <= destination.z+margin:
			isMoving = false
			print("Body is stopping")
		else:
			self.move_and_collide(velocity*0.01)
	pass
	
func select():
	$UnitSelect.show()
	pass
	
func deSelect():
	$UnitSelect.hide()
	pass

#Inner class
class UnitTask:
	var taskType = ""
	var action = null
	var targetNode= null
	var sourceNode = null
	
	func newHarvestTask(SourceNode ,TargetNode):
		pass