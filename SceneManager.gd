extends Node


@onready var currentScene : Node
@onready var currentWorld : Node
@onready var persistantData : Dictionary


func _ready() -> void:
	switchWorlds("res://Game Screens/Scenes/MainGameScreen.tscn")

func transferDataBetweenScenes(newSceneInstance : Node, dataToTransfer : Dictionary = {}) -> void :
	
	if newSceneInstance.has_method("loadPersistantData"):
		newSceneInstance.loadPersistantData(dataToTransfer)
		
	

func switchScenes(scenePath : String = "", dataToTransfer : Dictionary = {}) -> void :
	if scenePath : 
		var newScene = load(scenePath) as Resource
		var newSceneInstance = instantiateNewScene(newScene, false)
		if dataToTransfer:
			transferDataBetweenScenes(newSceneInstance, dataToTransfer)
		removeCurrentScene()
		$World.visible = false
		currentWorld.get_node("UI Nodes").visible = false
		currentScene = newSceneInstance
	else :
		if dataToTransfer:
			transferDataBetweenScenes(currentWorld, dataToTransfer)
		removeCurrentScene()
		$World.visible = true
		currentWorld.get_node("UI Nodes").visible = true
		currentScene = null
		
func removeCurrentScene() -> void :
		if currentScene:
			currentScene.disconnect("exitCurrentScene", switchScenes)
			currentScene.queue_free()
	
func switchWorlds(worldPath: String) -> void:
	var newWorld = load(worldPath) as Resource
	if currentWorld :
		currentScene.disconnect("exitCurrentScene", switchScenes)
		currentScene.disconnect("exitWorld", switchWorlds)
		currentWorld.queue_free()
	currentWorld = instantiateNewScene(newWorld, true)


	


func instantiateNewScene(newScene : Resource, isWorld : bool) -> Node:
	var instantiatedScene = newScene.instantiate()
	if isWorld:
		$World.add_child(instantiatedScene)
		
	else :
		$Scene.add_child(instantiatedScene)
	instantiatedScene.connect("exitCurrentScene", switchScenes)
	return instantiatedScene
	
