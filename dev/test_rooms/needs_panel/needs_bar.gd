extends ProgressBar

## Contains the signal method. Updates the bar on need ticked.
func update_label(need: Needs)-> void:
	value = need.need
