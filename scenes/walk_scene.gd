extends Node2D

@export var minigame_path: NodePath
var minigame
@onready var player = $Player

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	minigame = get_node(minigame_path)

func _on_steal_result(result):
	if result == "perfect":
		var item = %ItemDatabase.get_random_item()
		print(item)
		%InventoryUI.add_item(item)
	elif result == "fail":
		print("Steal failed!")
	player.can_walk = true
