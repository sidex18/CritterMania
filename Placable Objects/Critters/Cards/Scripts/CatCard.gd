extends BaseCritterCard



func _on_pressed() -> void:
	
	buyingACritter.emit(critter) 
	
