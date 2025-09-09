extends Camera2D


@export var zoom_speed: float = 0.05   # how fast zoom changes
@export var min_zoom: float = 0.5     # smallest zoom (zoom in most)
@export var max_zoom: float = 0.5     # largest zoom (zoom out most)

func _unhandled_input(event):
	if event is InputEventMouseButton and event.pressed:
		if event.button_index == MOUSE_BUTTON_WHEEL_UP:
			_set_zoom(zoom - Vector2(zoom_speed, zoom_speed))
		elif event.button_index == MOUSE_BUTTON_WHEEL_DOWN:
			_set_zoom(zoom + Vector2(zoom_speed, zoom_speed))

func _set_zoom(new_zoom: Vector2):
	new_zoom.x = clamp(new_zoom.x, min_zoom, max_zoom)
	new_zoom.y = clamp(new_zoom.y, min_zoom, max_zoom)
	zoom = new_zoom
