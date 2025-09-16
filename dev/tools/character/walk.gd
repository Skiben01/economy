extends LimboState

@onready var nav: NavigationAgent2D = %Nav

## Called on every frame
func _update(_delta: float) -> void:
	agent.position = nav.get_next_path_position()

## Called on unhandled input. Used to move the character
func _input(event: InputEvent) -> void:
	if event.is_action_pressed("walk_to"):
		nav.target_position = agent.get_viewport().get_mouse_position()
		dispatch("walk_to")
