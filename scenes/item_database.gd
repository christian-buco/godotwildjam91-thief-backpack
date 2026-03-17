extends Node

var items = []
var gold: int = 0
@export var gold_goal: int = 20

@onready var win_lose_manager = get_tree().get_first_node_in_group("win_lose_manager")
@onready var win_lose_level = get_tree().get_first_node_in_group("win_lose_level")
@onready var suspicion_bar = get_tree().get_first_node_in_group("suspicion_bar")
@onready var player = get_tree().get_first_node_in_group("player")
@onready var gold_label = get_tree().get_first_node_in_group("gold_label")

var suspicion := 0
var suspicion_max := 100

var is_game_over := false

func _ready():
	items = [
		Item.new("Apple", preload("res://assets/items/apple.png"), 1, 0.0, -0.1,
		"A stolen apple. Sticky fingers make stealing harder.\n-10% success zone"),

		Item.new("Coin", preload("res://assets/items/coin.png"), 2, 0.25, 0.0,
		"A loose coin that jingles in your pocket.\n+25% needle speed"),

		Item.new("Potion", preload("res://assets/items/potion.png"), 3, 0.05, -0.05,
		"A strange potion with unpredictable effects.\n+5% needle speed\n-5% success zone"),

		Item.new("Ring", preload("res://assets/items/ring.png"), 5, 0.5, 0.0,
		"A shiny ring that catches attention.\n+50% needle speed"),

		Item.new("Necklace", preload("res://assets/items/necklace.png"), 7, 0.0, -0.15,
		"A bulky necklace that slows your hands.\n-15% success zone"),

		Item.new("Gem", preload("res://assets/items/gem.png"), 10, 0.25, -0.25,
		"A brilliant gem too valuable to ignore.\n+15% needle speed\n-25% success zone"),

		Item.new("Gold Bar", preload("res://assets/items/gold.png"), 15, 0.0, -0.50,
		"A heavy gold bar weighing you down.\n-50% success zone")
	]
	
	update_gold_ui()
	
func get_random_item():
	return items.pick_random()

func check_win():
	is_game_over = true
	if gold >= gold_goal:
		print("WIN")
		#win_lose_manager.game_won()
		win_lose_level.level_won.emit()
	else:
		print("LOSE")
		win_lose_level.level_lost.emit()

func update_gold_ui():
	gold_label.text = "Total Gold: " + str(gold) + " / " + str(gold_goal)

func add_suspicion(amount):
	suspicion += amount
	suspicion = clamp(suspicion, 0, suspicion_max)
	
	suspicion_bar.value = suspicion
	if suspicion >= suspicion_max:
		is_game_over = true
		print("LOSE CAUSE OF BAR")
		win_lose_level.level_lost.emit()
