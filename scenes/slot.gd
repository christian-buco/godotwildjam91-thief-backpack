extends Panel

@onready var icon = $TextureRect

var item = null

func set_item(new_item):
	item = new_item
	
	if item == null:
		icon.visible = false
	else:
		icon.visible = true
		icon.texture = item.icon


func _on_mouse_entered() -> void:
	if item:
		print(item.name)
