class_name NeedsManager extends Node

## Will manage and signal when a [needs] reach importance. 
##
## Needs are taken as the children of [member target].

## Emitted when a new highest need emerges.
signal highest_need_emerged(need: Needs)

## Emitted when the needs_list changed
signal target_changed

## The managed needs.
var needs_list: Array = []

## The target node where the needs are managed.
@export var target: Node : set = set_target

## The latest highest need.
var _highest_need: Needs

## Called on node entered tree.
func _ready() -> void:
	# Calls setters
	target = target


## Assign target. updates [member needs_list]
func set_target(node: Node) -> void:
	needs_list = []
	target = node
	
	# Waits for node to be ready.
	if not target.is_node_ready():
		await target.ready
	
	# Skips initializing if empty
	if target:
		needs_list = _get_needs(target)
	
	target_changed.emit()


## Get back all Needs under node:
func _get_needs(node : Node) -> Array:
	var arr: Array = []
	for child in node.get_children():
		arr = arr + _get_needs(child)
		if child is Needs:
			arr.append(child)

	return arr


## Called on every physics frame
func _physics_process(delta: float) -> void:
	for need in needs_list:
		need = need as Needs
		need.tick(delta)
	
	update_highest_need()


## Checks and updates whos the highest need.
func update_highest_need() -> void:
	# If prev and new value, emit [signal highest_need_emerged] signal
	var previous_need: Needs = _highest_need
	
	# Sorts to get highest one
	needs_list.sort_custom(
		func sort(a, b):
			return a.need > b.need
	)
	
	# Sends out signal if there's new need entirely.
	_highest_need = needs_list.front()
	if previous_need != _highest_need:
		highest_need_emerged.emit(_highest_need)
