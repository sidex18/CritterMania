extends Resource
class_name SavePlants

@export var allPlants : Dictionary
const SAVEPATH = "user://savePlants.tres"


func writeSave() -> void :
	ResourceSaver.save(self, SAVEPATH)

static func loadSave() -> Resource :
	return ResourceLoader.load(SAVEPATH,"",ResourceLoader.CACHE_MODE_IGNORE)
static func saveFileExists() -> bool :
	return ResourceLoader.exists(SAVEPATH)
	
