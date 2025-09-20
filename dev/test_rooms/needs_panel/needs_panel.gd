extends Panel

func _ready() -> void:
	for need in get_tree().get_nodes_in_group(Needs.GROUP_NAME):
		need = need as Needs
		need.maxed.connect(
			func():
				need.need = 0
				print(Time.get_ticks_msec() / 1000)
		)
