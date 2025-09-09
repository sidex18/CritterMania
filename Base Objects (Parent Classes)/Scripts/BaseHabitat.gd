extends Node2D
class_name BaseHabitat


@export var dataToSave : HabitatData
var healthyPlants : int
var id : String
var dataToTransfer : Dictionary
var currentCritters : Array[BaseCritter]


signal healthyPlantsChanged(healthyPlants : int)
signal userWantsCritterHere(selfReference : BaseHabitat)
signal exitCurrentScene(newScene : String, data : Dictionary)

### Habitats will act as a router of sorts, 
### Placable objects in its domain will connect signals to the habitat and it will dispatch them accordingly


func _on_habitat_area_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	
	if Input.is_action_pressed("Click"):
		match GameManager.currentState :
			GameManager.State.CRITTER_PLACING:
				userWantsCritterHere.emit(self)
			GameManager.State.DEFAULT:
				$CrittersButton.visible = !$CrittersButton.visible
		
		
func connectCritterToHabitat(critter : BaseCritter) -> void:
	# Connects necessary critter types to habitat signals or habitat to critter signals
	match critter.critterTrait:
		"Plant Lover":
			critter.connectToHabitat(healthyPlantsChanged)
			healthyPlantsChanged.emit(healthyPlants)
			
		"Twins": 
			critter.twinLevelUpdated.connect(checkAllSameCritters)
			critter.twinLevelChanged()
			print("Twins added to habitat")
			

func placeCritterSuccessful(critterToPlace : String) -> void :
	var newCritter = CritterFactory.create(critterToPlace)
	#(newCritter)

	currentCritters.append(newCritter)
	if dataToSave:
		dataToSave.habitatCritters.append(newCritter.dataToSave)
	
	var add_later = func():
		add_child(newCritter)
		placeCritterInCorrectPosition(newCritter)
		
	add_later.call_deferred()
	connectCritterToHabitat(newCritter)

func placeCritterInCorrectPosition(newCritter) -> void:
	if dataToSave.positionalMarker1:
		newCritter.global_position = $PositionMarkers/Marker1.global_position
		dataToSave.positionalMarker1 = false
	elif dataToSave.positionalMarker2:
		newCritter.global_position = $PositionMarkers/Marker2.global_position
		dataToSave.positionalMarker2 = false
### Signal Connectors for placable objects
func updateHealthyPlants(plantWatered : bool) -> void :
	if plantWatered:
		healthyPlants += 1
		print("Healthy plants are now 1")
		#("A plant has been watered and incremented my plant count")
	elif not plantWatered:
		healthyPlants -= 1
		print("Healthy plants are now 0")
		#("A plant is not watered and has reduced my plant count")
	
	healthyPlantsChanged.emit(healthyPlants)

func checkAllSameCritters(twin : Twins) -> void :
	var isHappy = false
	for critter in currentCritters:
		if critter.critterCardName == twin.critterCardName and twin != critter :
			isHappy = (critter.checkTwinsLevel(twin.dataToSave.level)) or isHappy
	
	twin.dataToSave.isHappy = isHappy
	

		
		
### Methods that require check happiness conditions
func _on_proximity_area_entered(area: Area2D) -> void:
	if area in get_tree().get_nodes_in_group("Plants"):
		updateHealthyPlants(area.dataToSave.watered)
		area.connect("wateredStateChanged", updateHealthyPlants)
func _on_proximity_area_exited(area: Area2D) -> void:
	if area in get_tree().get_nodes_in_group("Plants"):
		healthyPlants -= 1
		area.disconnect("wateredStateChanged", updateHealthyPlants)


func dataload() -> void :
	dataToSave.position = self.global_position 
	SaveAutload.saveHabitatCritters.allHabitats[id] = dataToSave
	print("Saved Habitat")


func _on_critters_button_pressed() -> void:
	dataToTransfer = {
		habitatCritters = currentCritters,
		habitatLevel = dataToSave.level
	}
	exitCurrentScene.emit("res://Game Screens/Scenes/CritterDetailsInterface.tscn", dataToTransfer)
