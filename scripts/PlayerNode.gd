extends KinematicBody

const unitFactory = preload("res://scripts/UnitFactory.gd")
const Unit = preload("res://prefabs/Unit.gd")
const Town = preload("res://prefabs/Town.gd")

var selectedUnits= []
var numFollowers = 0

func _ready():
	self.move_and_collide(Vector3(0,15,-10))
	$Camera.rotate(Vector3(1,0,0),PI*0.15)
	pass

func _physics_process(delta):
	var velocity = Vector3(0,0,0)
	
	if Input.is_action_pressed("move_left"):
		velocity.x += 10*delta
	elif Input.is_action_pressed("move_right"):
		velocity.x -= 10*delta
	
	if Input.is_action_pressed("move_forward"):
		velocity.z += 10*delta
	elif Input.is_action_pressed("move_backward"):
		velocity.z -= 10*delta
	
	if Input.is_action_pressed("move_up"):
		velocity.y += 10*delta
	elif Input.is_action_pressed("move_down"):
		velocity.y -= 10*delta
	
	if Input.is_action_just_pressed("build_imp"):
		var root = get_tree().get_root()
		var imp = unitFactory.build_imp_unit()
		root.add_child(imp)
		
	if Input.is_action_just_pressed("select"):
		var excludeArray = [self, get_node("../Terrain")]		
		var collideMainLayer = 1
		var result = mouseRayCast(1000,excludeArray, collideMainLayer)
		if result:
			#Mutate selected node 
			var targetNode = result.collider
			
			#Unit selection
			if targetNode is Unit:
				deSelectUnits(selectedUnits)
				selectedUnits.clear() # Clear the selected units
				selectedUnits.append(targetNode) #Add the new selected unit
				targetNode.select()
			
			#Debug print
			print("Node:", result.collider.name)
			print("Hit at point: ", result.position)
		else:
			if selectedUnits.size() > 0: deSelectUnits(selectedUnits)

	if Input.is_action_just_pressed("go_to"):
		var collideMainLayer = 1
		var result = mouseRayCast(1000,[self],collideMainLayer)
		var node = result.collider
		
		if node is Town:
			var coords = result.position
			if selectedUnits.size() > 0:
				moveAndHarvest(coords,selectedUnits)
				print("MoveAndHarvest")
		else:
			var terrainCoords = result.position
			if selectedUnits.size() > 0:
				moveUnits(terrainCoords,selectedUnits)

	self.move_and_collide(velocity)
	pass

func mouseRayCast(rayLength,excludeArray,collideOnLayer):
	var space_state = get_world().direct_space_state
	var mousePos = get_viewport().get_mouse_position()
	var from = $Camera.project_ray_origin(mousePos)
	var to = from + $Camera.project_ray_normal(mousePos) * rayLength
	var result = space_state.intersect_ray(from,to,excludeArray,collideOnLayer)
	return result

func moveUnits(targetPos,units):
	for item in units:
		var unitPos = item.translation
		var distance = Vector3(targetPos.x-unitPos.x,0,targetPos.z-unitPos.z)
		var velocity = distance
		item.isMoving = true
		item.velocity = velocity
		item.destination = targetPos
		print("From: " + str(unitPos) + " To: " + str(targetPos) + " Velocity: " + str(velocity))
	pass

func moveAndHarvest(targetPos, units):
	moveUnits(targetPos,units)
	setUnitsState(Unit.STATE.HARVEST, units)
	pass
	
func setUnitsState(unitState, units):
	for item in units:
		item.currentState = unitState
	pass 

func deSelectUnits(units):
	for item in units:
		item.deSelect()
	pass

func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
	pass
