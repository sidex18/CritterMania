extends Area2D

var objectToPlaceData : Dictionary
var world : TileMapLayer
var environmentalObjects : Node2D
var overlappingObjects : int 

signal placementComplete(placedObject : Node2D)
@export var red : Color

func initPlacementTool(worldReference : TileMapLayer, objectData : Dictionary, eObjects : Node2D) -> void:
	world = worldReference
	objectToPlaceData = objectData
	environmentalObjects = eObjects
	
	

func _process(delta: float) -> void:
	if objectToPlaceData:
		self.global_position = world.map_to_local(world.local_to_map(get_global_mouse_position()))
		if overlappingObjects > 0 :
			modulate = red
		else: 
			modulate.r = 1
			modulate.g = 1
			modulate.b = 1

		
		


func _on_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	var createdObject 
	if event.is_action_pressed("Click") and overlappingObjects <= 0:
		match objectToPlaceData.objectType:
			"Plant" :
				createdObject = PlantFactory.create(objectToPlaceData.objectPath, global_position)
			"Habitat":
				createdObject = HabitatFactory.create(objectToPlaceData.objectPath, global_position)
				
				
				
		GameManager.toggleState(GameManager.State.DEFAULT)
		objectToPlaceData = {}
		SignalBus.placeInEnvironment.emit(createdObject)
		self.visible = false


func _on_area_entered(area: Area2D) -> void:
	overlappingObjects += 1
	


func _on_area_exited(area: Area2D) -> void:
	overlappingObjects -= 1
