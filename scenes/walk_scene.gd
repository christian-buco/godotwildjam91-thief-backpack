extends Node2D

@export var minigame_path: NodePath
var minigame
@onready var player = $Player

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	minigame = get_node(minigame_path)

func _on_npc_encounter_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		print("Encounter started")
		body.can_walk = false
		minigame.start_steal(_on_steal_result)
		
func _on_steal_result(result):
	if result == "perfect":
		print("Item stolen!")
	elif result == "fail":
		print("Steal failed!")
	player.can_walk = true
