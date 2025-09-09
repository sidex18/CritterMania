extends Node2D


var lastTimeUnix : int 
var timeOpenedUnix : int 
var environmentalObjects : Node2D




func triggerLoadOnEntry(eObjects : Node2D) -> void :
	environmentalObjects = eObjects
	lastTimeUnix = SaveAutload.saveGameData.lastActiveUnixTime
	timeOpenedUnix = Time.get_unix_time_from_system()
	loadSavedHabitatsCritters()
	loadSavedPlants()


# Function that loads all the habitats and critters
func loadSavedHabitatsCritters() -> void :
	# Load the resource that stores all the habitats resources
	var allHabs = SaveAutload.saveHabitatCritters.allHabitats
	
	
	# Thr resources are saved in a dictionary with their uniquw id 
	for habitatID in allHabs.keys():
		# Extract the resource
		var savedHabitatRes = allHabs[habitatID]
		# Resource stores the scene path of the habitat so it can be instantiated
		var habitatInstance = HabitatFactory.restore( 
			savedHabitatRes, 
			habitatID
		)
	
	
		habitatInstance.add_to_group("Habitats")
		SignalBus.placeInEnvironment.emit(habitatInstance)
		
		for critterData in savedHabitatRes.habitatCritters:
			var critterInstance = CritterFactory.restore(
				critterData
			)
			
			habitatInstance.add_child(critterInstance)
			habitatInstance.currentCritters.append(critterInstance)
			critterInstance.global_position = critterData.position
			habitatInstance.connectCritterToHabitat(critterInstance)
		

func loadSavedPlants() -> void :
	var allPlants = SaveAutload.savePlants.allPlants 
	
	
	for plantID in allPlants.keys():
	
		var savedPlantRes = allPlants[plantID]
		
		
		if savedPlantRes.watered :
			savedPlantRes.timeToWilting = savedPlantRes.timeToWilting - (timeOpenedUnix - lastTimeUnix)
			if savedPlantRes.timeToWilting < 0 :
				savedPlantRes.watered = false
		var plantInstance = PlantFactory.restore(
			savedPlantRes,
			plantID
		)
		
	
		
	
	
		plantInstance.add_to_group("Plants")
		SignalBus.placeInEnvironment.emit(plantInstance)
		plantInstance.startTimer()
		
	
func _notification(what) -> void:
	if what == NOTIFICATION_WM_CLOSE_REQUEST:
		for objectToSave in get_tree().get_nodes_in_group("Savable Objects"):
			objectToSave.dataload()
		
		SaveAutload.writeSaveComponents()
		
			
			
