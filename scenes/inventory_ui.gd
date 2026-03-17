extends Control

@onready var slots = $GridContainer.get_children()
@export var max_slots := 9

var minigame
var items = []

func _ready():
	minigame = get_tree().get_first_node_in_group("minigame")
	
func add_item(item):
	if self.is_full():
		return false
		
	for slot in slots:
		if slot.item == null:
			slot.set_item(item)
			items.append(item)
			return true

func is_full():
	return items.size() >= max_slots
