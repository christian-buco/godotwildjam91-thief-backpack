extends Area2D

@export var npc_sprite: Texture2D
@export var steal_attempts: int = 3
@export var needle_speed: float = 400

var player
var minigame
var inventory
var encounter_ui
var game_controller

func _ready():
	$Sprite2D.texture = npc_sprite
	
	minigame = get_tree().get_first_node_in_group("minigame")
	inventory = get_tree().get_first_node_in_group("inventory")
	encounter_ui = get_tree().get_first_node_in_group("encounter_ui")
	game_controller = get_tree().get_first_node_in_group("game_controller")


func _on_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		player = body
		player.stop_walking()
		encounter_ui.start_encounter(self)

func attempt_steal():
	if steal_attempts <= 0:
		end_encounter()
		return
		
	minigame.needle_speed = needle_speed
	minigame.start_steal(_on_steal_result)

func _on_steal_result(result):
	if result == "perfect":
		steal_attempts -= 1
		
		var item = game_controller.get_random_item()
		inventory.add_item(item)
		game_controller.gold += item["value"]
		print(game_controller.gold)
		encounter_ui.attempts_label.text = "Steals Left: " + str(steal_attempts)
		
	if steal_attempts <= 0:
		end_encounter()
	else:
		minigame.disable_stop_button()
		encounter_ui.start_encounter(self)

func end_encounter():
	encounter_ui.end_encounter()
	player.resume_walking()
