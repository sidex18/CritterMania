extends Node
class_name HabitatFactory

const nameToHabitat : Dictionary = {
	"CatHabitat" : "res://Habitats/Scenes/CatHabitat.tscn"
}

static func restore(habitatRes : HabitatData, habitatID : String):
	var habitatInstance = load(habitatRes.scenePath).instantiate()
	habitatInstance.id = habitatID
	habitatInstance.dataToSave = habitatRes
	habitatInstance.position = habitatRes.position
	return habitatInstance
	
static func create(habitatPath : String, placementToolPosition : Vector2):
	var habitatInstance = load(habitatPath).instantiate()
	var rng = RandomNumberGenerator.new()
	rng.randomize()
	var randomID = ("HabitatID_" + str(rng.randi_range(1000, 9999)))
	
	while randomID in SaveAutload.saveHabitatCritters.allHabitats.keys():
		rng.randomize()
		randomID = ("HabitatID_" + str(rng.randi_range(1000, 9999)))
			
	habitatInstance.id = randomID
	var res = HabitatData.new()
	habitatInstance.global_position = placementToolPosition
	res.scenePath = habitatPath
	habitatInstance.dataToSave = res
	return habitatInstance
