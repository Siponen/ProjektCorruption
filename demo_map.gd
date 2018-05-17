extends Node

const townFactory = preload("res://scripts/TownFactory.gd")
const building = preload("res://prefabs/Building.tscn")
const seal = preload("res://prefabs/Seal.tscn")
const unit = preload("res://prefabs/Unit.tscn")

func _ready():
	var base = preload("res://prefabs/Base.tscn").instance()
	base.global_translate(Vector3(0,0,-12))
	self.add_child(base)
	
	#Fill world with buildings
	var midgar = townFactory.build_town("Midgar","Someone")
	midgar.global_translate(Vector3(10,0,10))
	self.add_child(midgar)
	
	#Populate buildings
	var newBuilding = building.instance()
	newBuilding.global_translate(Vector3(12,0,0))
	self.add_child(newBuilding)
	
	var newBuilding2 = building.instance()
	newBuilding2.global_translate(Vector3(0,0,10))
	self.add_child(newBuilding2)
		
	#Add seals
	var sealNorth = seal.instance()
	sealNorth.global_translate(Vector3(-20,0,-20))
	self.add_child(sealNorth)
	
	var sealWest = seal.instance()
	sealWest.global_translate(Vector3(-20,0,20))
	self.add_child(sealWest)
	
	var sealEast = seal.instance()
	sealEast.global_translate(Vector3(20,0,-20))
	self.add_child(sealEast)
	
	var sealSouth = seal.instance()
	sealSouth.global_translate(Vector3(20,0,20))
	self.add_child(sealSouth)
	
	#Add starter units
	var doomUnit = unit.instance()
	doomUnit.global_translate(Vector3(0,0,0))
	self.add_child(doomUnit)
		
	pass

#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass
