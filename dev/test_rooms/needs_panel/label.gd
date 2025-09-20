extends Label

func _on_needs_manager_highest_need_emerged(need: Needs) -> void:
	text = "Emerged: %s" % need.name
