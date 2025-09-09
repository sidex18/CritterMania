extends Node2D

signal exitCurrentScene(newScene : String)
signal exitWorld(newWorld : String)


@onready var environmentalObjects = $EnvironmentalObjects

func loadPersistantData(data:Dictionary):

	
	match GameManager.currentState:
		GameManager.State.OBJECT_PLACING :
			dispatchPlacement(data)
		GameManager.State.CRITTER_PLACING :
			dispatchCritterPlacing(data)
		


			
			
			
func dispatchPlacement(data : Dictionary) -> void:
	$PlacementTool.initPlacementTool($World,data,$EnvironmentalObjects)
	$PlacementTool.visible = true
	
func dispatchCritterPlacing(data : Dictionary) -> void:
	$EnvironmentalObjects.critterData = data
	
func _ready() -> void:
	environmentalObjects.connectEnvironment()
	environmentalObjects.connect("exitTrigger", eObjectsExit)
	
	$LoadSaveComponent.triggerLoadOnEntry($EnvironmentalObjects)
	$PlacementTool.connect("placementComplete",add_child)
	
	$WaterArea.visible = false
func _process(delta: float) -> void:
	if $WaterArea.visible:
		$WaterArea.global_position = get_global_mouse_position()	


func eObjectsExit(data : Dictionary, scenePath : String) -> void :
	exitCurrentScene.emit(scenePath, data)
func _on_shop_button_pressed() -> void:
	exitCurrentScene.emit("res://Game Screens/Scenes/CardCollectionScreen.tscn")


func _on_button_button_down() -> void:
	$WaterArea.visible = true
	
func _on_button_button_up() -> void:
	$WaterArea.visible = false


func _on_plant_shop_button_pressed() -> void :
	exitCurrentScene.emit("res://Game Screens/Scenes/PlantShop.tscn")
