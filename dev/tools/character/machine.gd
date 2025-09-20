extends LimboHSM

@onready var idle: LimboState = $Idle
@onready var walk: LimboState = $Walk

func _ready() -> void:
	add_transition($Idle, $Walk, "walk_to")
	add_transition($Walk, $Idle, "idle")
