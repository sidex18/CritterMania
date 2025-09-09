extends Node2D

signal exitTrigger(data : Dictionary, scenePath : String)
var critterData : Dictionary



func _ready() -> void:
	pass
	
func connectEnvironment() -> void:
	SignalBus.connect("placeInEnvironment",addToEnvironment)

func addToEnvironment(placableObject : Node2D) -> void :
	add_child(placableObject)
	if placableObject is BasePlant:
		placableObject.startTimer()
	if placableObject is BaseHabitat :
		placableObject.userWantsCritterHere.connect(dispatchCritterPlacement)
	if placableObject.has_signal("exitCurrentScene"):
		placableObject.connect("exitCurrentScene", exitSceneByEobject)
	

func dispatchCritterPlacement(habitatSelected : BaseHabitat) -> void :
	
	if critterData:
		habitatSelected.placeCritterSuccessful(critterData.critter)
	critterData = {}
	GameManager.toggleState(GameManager.State.DEFAULT)
func exitSceneByEobject(newScene : String, data : Dictionary) -> void :
	exitTrigger.emit(data,newScene)
	
