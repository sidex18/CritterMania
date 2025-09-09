extends Node

# Save Components

var saveHabitatCritters : SaveHabitatCritters
var savePlants : SavePlants
var saveGameData : SaveGameData

# Save Component's Dictionaries for easier access

var currAllHabitats : Dictionary = {}
var currAllPlants : Dictionary = {}

func _ready() -> void:
	loadOrCreateSaveComponents()

func loadOrCreateSaveComponents() -> void :

	if SaveHabitatCritters.saveFileExists() :
		saveHabitatCritters = SaveHabitatCritters.loadSave()
		currAllHabitats = saveHabitatCritters.allHabitats
	else :
		saveHabitatCritters = SaveHabitatCritters.new() 
		saveHabitatCritters.allHabitats = currAllHabitats
	if SavePlants.saveFileExists():
		savePlants = SavePlants.loadSave()
		currAllPlants = savePlants.allPlants
	else :
		savePlants = SavePlants.new() 
		savePlants.allPlants = currAllPlants
	if SaveGameData.saveFileExists():
		saveGameData = SaveGameData.loadSave()
	else :
		saveGameData = SaveGameData.new()
	

	
func writeSaveComponents() -> void :
	saveGameData.lastActiveUnixTime = Time.get_unix_time_from_system()
	savePlants.writeSave()
	saveHabitatCritters.writeSave()
	saveGameData.writeSave()
			
		

		
		
