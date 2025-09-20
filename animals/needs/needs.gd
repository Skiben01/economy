class_name Needs extends Node

## Needs will increase [member rate] over time.

## Emitted on needs on full. 
signal maxed

## Emitted when need ticked.
signal ticked

## The group name.
const GROUP_NAME: String = "needs"

## The current need value.
var need: float = 0 : set = set_need

## The amount of need will increase on every tick.
@export var time_seconds: float = 0.0

func _ready() -> void:
	add_to_group(GROUP_NAME)


## Assigns need.
func set_need(value: float) -> void:
	need = clampf(value, 0.00, 1.0)

## Called on every tick.
func tick(delta: float) -> void:
	need += (delta / time_seconds)
	
	if need >= 1.0:
		maxed.emit()
	
	ticked.emit()
