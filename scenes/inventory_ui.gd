extends Control

@onready var slots = $GridContainer.get_children()

func add_item(item):
	for slot in slots:
		if slot.item == null:
			slot.set_item(item)
			return true
	return false
