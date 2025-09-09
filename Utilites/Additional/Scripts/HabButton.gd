extends Button
var habitat
var plant 
var selected : bool


func _on_button_pressed() -> void:
	#habitat = HabitatFactory.create( 
		#"CatHabitat",
		#HabitatData.new(),
		#get_global_mouse_position(),
		#"New Habitat"	
	#)
	#habitat.global_position = get_global_mouse_position()
	#call_deferred("add_child", habitat)
	#selected = true
	#plant = PlantFactory.create( 
		#"Rose",
		#PlantData.new(),
		#$World.local_to_map(get_global_mouse_position()),
		#true,
		#-1,
		#"New Plant"	
	#)
	#add_child(plant)
	#plant.startTimer()
	#selected = true
	#
	
	
	pass
func _physics_process(delta):
	pass
func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and not event.pressed:
			selected = false
			
