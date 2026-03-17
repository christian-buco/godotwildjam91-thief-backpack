extends Area2D

@export var npc_sprite: Texture2D
@export var steal_attempts: int = 3

var player
var minigame
var inventory
var encounter_ui
var game_controller

func _ready():
	$Sprite2D.texture = npc_sprite
	
	$AttemptsLabel.text = str(steal_attempts)
	minigame = get_tree().get_first_node_in_group("minigame")
	inventory = get_tree().get_first_node_in_group("inventory")
	encounter_ui = get_tree().get_first_node_in_group("encounter_ui")
	game_controller = get_tree().get_first_node_in_group("game_controller")

func update_label():
	if steal_attempts <= 0:
		$AttemptsLabel.text = ""
	else:
		$AttemptsLabel.text = str(steal_attempts)

func _on_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		player = body
		player.stop_walking()
		encounter_ui.start_encounter(self)

func attempt_steal():
	if inventory.is_full():
		end_encounter()
		return
	if steal_attempts <= 0:
		end_encounter()
		return
		
	minigame.reset_difficulty()
	minigame.apply_inventory_modifiers(inventory.items)
	minigame.start_steal(_on_steal_result)

func _on_steal_result(result):
	if result == "fail":
		steal_attempts -= 1
		game_controller.add_suspicion(25)
		encounter_ui.attempts_label.text = "Steals Left: " + str(steal_attempts)
		update_label()
		
	if result == "perfect":
		steal_attempts -= 1
		
		var item = game_controller.get_random_item()
		inventory.add_item(item)
		game_controller.gold += item["value"]
		print(game_controller.gold)
		encounter_ui.attempts_label.text = "Steals Left: " + str(steal_attempts)
		update_label()
		game_controller.update_gold_ui()
		minigame.apply_inventory_modifiers(inventory.items)
	if steal_attempts <= 0:
		minigame.disable_stop_button()
		end_encounter()
	else:
		minigame.disable_stop_button()
		encounter_ui.start_encounter(self)

func end_encounter():
	encounter_ui.end_encounter()
	player.resume_walking()
