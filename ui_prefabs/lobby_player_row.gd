extends HBoxContainer

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	pass

func setName(name):
	$Name.Text = name
	pass

func setFaction(faction):
	$Faction.Text = faction
	pass

func setColor(r,g,b):
	$ColorRect.color = Color(r,g,b,255)
	pass


#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass
