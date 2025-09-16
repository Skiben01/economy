extends Node2D

@onready var machine: LimboHSM = %Machine

## Added to tree.
func _ready():
	machine.initialize(self)
	machine.set_active(true)
