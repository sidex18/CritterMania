extends BaseCritter
class_name PlantLover
@export var minRequiredPlants : int 


func _ready() -> void:
	checkHappinessState = checkNumberOfPlants

func connectToHabitat(happinessCondition : Signal):
	happinessCondition.connect(checkNumberOfPlants)
func checkNumberOfPlants(healthyPlants : int) :

	if healthyPlants < minRequiredPlants:
	
		updateHappiness(false)
	else :
		
		updateHappiness(true)
		
	
