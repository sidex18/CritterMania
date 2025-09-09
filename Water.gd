extends Node2D

var dragging : bool = false
var offset : Vector2 = Vector2(0,0)
var originalOffset : Vector2 = Vector2(-52,-55)



func _process(delta: float) -> void:
	if dragging :
		self.global_position = get_global_mouse_position() - offset
	


func _on_button_button_down() -> void:
	dragging = true
	



func _on_button_button_up() -> void:
	dragging = false
	self.global_position = get_viewport_rect().size + originalOffset
