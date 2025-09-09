extends Resource
class_name SaveGameData

@export var coins : int = 0
@export var gems : int = 0
@export var lastActiveUnixTime : int = 0
const SAVEPATH = "user://saveGameData.tres"


func writeSave() -> void :
	ResourceSaver.save(self, SAVEPATH)

static func loadSave() -> Resource :
	return ResourceLoader.load(SAVEPATH,"",ResourceLoader.CACHE_MODE_IGNORE)
	
static func saveFileExists() -> bool :
	return ResourceLoader.exists(SAVEPATH)
