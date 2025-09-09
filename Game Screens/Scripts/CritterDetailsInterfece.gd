extends Control

var habitatCritters : Array[BaseCritter]
var habitatLevel : int 

signal exitCurrentScene(scenePath : String)

# Current Critter to display 
var currentCritterToDisplay : BaseCritter
func loadPersistantData(data:Dictionary) -> void:
	habitatCritters = data.habitatCritters
	habitatLevel = data.habitatLevel
	#(data)

	initCritterInterface()
	

func initCritterInterface() -> void:

	# Depending on size of habitatCritters and level of the habitat make buttons available
	
	#(habitatCritters)
	
	# Setup critter visual interface
	currentCritterToDisplay = habitatCritters[0]
	updateDisplay()

	
func _ready() -> void:
	pass # Replace with function body.


func updateDisplay() -> void:
	var sprite = currentCritterToDisplay.get_node("CatSprite") as AnimatedSprite2D
	var dupe := sprite.duplicate() as AnimatedSprite2D
	dupe.sprite_frames = sprite.sprite_frames
	dupe.animation = "default"
	add_child(dupe)
	dupe.global_position = Vector2(500,500)




func _on_exit_button_pressed() -> void:
	print("End critter details screen")
	for critters in habitatCritters:
		if critters is Twins:
			critters.exitFeedMenu()
	exitCurrentScene.emit("")
	
	

	

				
			
func _on_feed_button_pressed() -> void:
	if currentCritterToDisplay.dataToSave.levelProgress == 6 and currentCritterToDisplay is Twins:
		currentCritterToDisplay.twinLevelChanged()
	currentCritterToDisplay.dataToSave.levelProgress += 1
