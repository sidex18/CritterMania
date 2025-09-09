extends Area2D

var originalOffset : Vector2 = Vector2(-119,-66)



func _on_area_entered(area: Area2D) -> void:
	if area in get_tree().get_nodes_in_group("Plants"):
		area.water() # Replace with function body.
