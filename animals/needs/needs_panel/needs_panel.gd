extends GridContainer

## Displays the contents of [NeedsManager]

## The custom progress bar.
const BAR: Script = preload("res://dev/test_rooms/needs_panel/needs_bar.gd")

## Called on node entered.
@export var manager: NeedsManager :  set = set_manager

## Called on node entered
func _ready() -> void:
	# Calls setter
	manager = manager
	_on_manager_target_changed()


## Assigns the manager.
func set_manager(value: NeedsManager) -> void:
	# Sets
	var prev: NeedsManager = manager
	manager = value
	
	# Skips if there's no new manager
	if not manager:
		return
	
	# Disconnects old signal
	if manager != prev:
		if prev:
			prev.target_changed.disconnect(_on_manager_target_changed)
		# Connects new signal
		manager.target_changed.connect(_on_manager_target_changed)


## Called on manager's target changed
func _on_manager_target_changed() -> void:
	for child in get_children():
		child.queue_free()
	
	for need in manager.needs_list:
		need = need as Needs
		# Adds label
		var label: Label = Label.new()
		add_child(label)
		label.text = need.name
		
		# Adds label
		var bar: ProgressBar = BAR.new()
		add_child(bar)
		bar.step = 0.001
		bar.max_value = 1.0
		bar.value = need.need
		bar.size_flags_horizontal = Control.SIZE_EXPAND_FILL
		
		need.ticked.connect(bar.update_label.bind(need))
