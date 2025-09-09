extends Control

var toggleVisibility : bool = false



func _on_button_pressed() -> void:
	if toggleVisibility:
		$"Popping Animation".play("Closing")
		toggleVisibility = false
	elif not toggleVisibility:
		$"Popping Animation".play("Opening")
		toggleVisibility = true
