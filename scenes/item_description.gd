extends Panel

@onready var label = $RichTextLabel


func show_item(item):

	if item == null:
		label.text = ""
		return

	label.text = item.name + "\nValue: " + str(item.value) + "\n\n" + item.description
