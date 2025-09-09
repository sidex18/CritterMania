extends Control


signal exitCurrentScene(scenePath : String)


func _on_habitat_button_pressed()->void:
	var dataToTransfer = {
		objectPath = "res://Placable Objects/Habitats/Scenes/CatHabitat.tscn",
		objectType = "Habitat",
		objectScale = 1
	}
	
	
	GameManager.toggleState(GameManager.State.OBJECT_PLACING)
	exitCurrentScene.emit("", dataToTransfer)
func _on_button_pressed() -> void:
	var dataToTransfer = {
		objectPath = "res://Placable Objects/Plants/Scenes/RosePlant.tscn",
		objectType = "Plant",
		objectScale = 1
	}
	
	
	
	GameManager.toggleState(GameManager.State.OBJECT_PLACING)
	exitCurrentScene.emit("", dataToTransfer)
