extends Area2D
class_name BasePlant
var selected : bool
var dataToSave : PlantData
var healthyToWilted : int = 60
var id : String 
signal wateredStateChanged(watered : bool)

# Plants should be able to move around, and get wilted
# Wilted plants will send a signal to nearby habitats that will then decrement the
# count of that habitats healthy planys

# When watered, plants should emit another signal to nearby plants and increment its healthy 
# plants count



# Called when the node enters the scene tree for the first time.



func initSavedTime(timeToWiliting):
	$Timer.wait_time = timeToWiliting
	
	
	
func startTimer():
	if dataToSave.watered :
		$Timer.start()
		

func water():
	dataToSave.watered = true
	$Timer.wait_time = healthyToWilted
	updateAppearance()
	startTimer()
	wateredStateChanged.emit(dataToSave.watered)



func _physics_process(delta):
	if selected :
		global_position = lerp(global_position, get_global_mouse_position(), 25*delta)
	


func updateAppearance() -> void :
	if dataToSave.watered :
		$AnimatedSprite2D.play("default")
	elif not dataToSave.watered : 
		$AnimatedSprite2D.play("dry ")
	
							
func dataload() -> void:
	dataToSave.position = self.global_position
	dataToSave.timeToWilting = $Timer.time_left
	SaveAutload.savePlants.allPlants[id] = dataToSave
	print("Saved")




func _on_timer_timeout() -> void:
	dataToSave.watered = false
	wateredStateChanged.emit(dataToSave.watered)
	updateAppearance()
	
	
