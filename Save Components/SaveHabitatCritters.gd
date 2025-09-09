extends Resource
class_name SaveHabitatCritters


@export var allHabitats : Dictionary
const SAVEPATH = "user://saveHabitatCritters.tres"


func writeSave() -> void :
	ResourceSaver.save(self, SAVEPATH)

static func loadSave() -> Resource :
	return ResourceLoader.load(SAVEPATH,"",ResourceLoader.CACHE_MODE_IGNORE)
	
static func saveFileExists() -> bool :
	return ResourceLoader.exists(SAVEPATH)
	
