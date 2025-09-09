extends Control

signal exitCurrentScene(newScene : String)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	refreshUI()
	
	

func refreshUI():
	pass
		
	


func _on_exit_button_pressed() -> void:
	get_tree().change_scene_to_file("res://Game Screens/Scenes/MainGameScreen.tscn") # Replace with function body.


func buyCritter(critterToCreate: String) -> void:
	GameManager.toggleState(GameManager.State.CRITTER_PLACING)
	var dataToTransfer = {
		critter = critterToCreate
	}

	exitCurrentScene.emit("", dataToTransfer)
