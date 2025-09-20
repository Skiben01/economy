extends Camera2D

## The zoom in and zoom out step.
const ZOOM_SPEED: float = 2.0
const CAM_SPEED: float = 2.0

## Called on input.
func _unhandled_input(event: InputEvent) -> void:
	# Zooms int/out
	if event.is_action_pressed("zoom_in"):
		zoom += Vector2(ZOOM_SPEED, ZOOM_SPEED)
	elif event.is_action_pressed("zoom_out"):
		zoom -= Vector2(ZOOM_SPEED, ZOOM_SPEED)
	zoom = zoom.clamp(Vector2.ONE, Vector2(50, 50))

	# moves left and right
	if event.is_action("cam_left"):
		position.x -= CAM_SPEED
	elif event.is_action("cam_right"):
		position.x += CAM_SPEED

	# moves up/down
	if event.is_action("cam_up"):
		position.y -= CAM_SPEED
	elif event.is_action("cam_down"):
		position.y += CAM_SPEED
