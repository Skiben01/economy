extends LimboState

const SPEED: float = 50

@onready var nav: NavigationAgent2D = %Nav
@onready var anim: AnimationPlayer = $Anim

func _enter() -> void:
	anim.play("Walk")
	nav.navigation_finished.connect(_on_nav_finished, CONNECT_ONE_SHOT)

## Called on every frame
func _update(_delta: float) -> void:
	agent.global_position = agent.global_position.move_toward(nav.get_next_path_position(), _delta * SPEED)

func _on_nav_finished() -> void:
	agent.machine.dispatch("idle")
	set_process_input(true)

## Called on unhandled input. Used to move the character
func _input(event: InputEvent) -> void:
	if event.is_action_pressed("walk_to"):
		%Nav.target_position = agent.get_viewport().get_mouse_position()
		dispatch("walk_to")
