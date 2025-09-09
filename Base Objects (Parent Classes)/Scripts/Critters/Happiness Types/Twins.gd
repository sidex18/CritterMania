extends BaseCritter
class_name Twins 

signal twinLevelUpdated(selfReference : Twins)


func twinLevelChanged() -> void :
	print("Twins level changed")
	twinLevelUpdated.emit(self)
func checkTwinsLevel(twinLevel : int) -> bool:
	if twinLevel == dataToSave.level:
		dataToSave.isHappy = true
		return true
	return false
