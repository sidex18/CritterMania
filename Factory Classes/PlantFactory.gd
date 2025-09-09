extends Node

class_name PlantFactory



static func restore(plantRes : PlantData, plantID : String):
	var plantInstance = load(plantRes.scenePath).instantiate()
	plantInstance.dataToSave = plantRes
	plantInstance.updateAppearance()
	plantInstance.id = plantID
	plantInstance.global_position = plantRes.position
	if plantRes.timeToWilting>0:
		plantInstance.initSavedTime(plantRes.timeToWilting)
	
	
	return plantInstance

static func create(plantPath : String, placementToolPosition : Vector2): 
	var rng = RandomNumberGenerator.new()
	rng.randomize()
	var randomID = ("PlantID_" + str(rng.randi_range(1000, 9999)))
	
	while randomID in SaveAutload.savePlants.allPlants.keys():
		rng.randomize()
		randomID = ("PlantID_" + str(rng.randi_range(1000, 9999)))
	var plantInstance = load(plantPath).instantiate()
	var res = PlantData.new()
	plantInstance.global_position = placementToolPosition
	res.scenePath = plantPath
	plantInstance.dataToSave = res 
	plantInstance.updateAppearance()
	plantInstance.id = randomID
	
	
	return plantInstance
