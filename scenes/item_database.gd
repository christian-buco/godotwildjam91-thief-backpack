extends Node

var items = []
var gold: int = 0

func _ready():
	items = [
		Item.new("Coin", preload("res://assets/player.png"), 5)
	]
	
func get_random_item():
	return items.pick_random()

func check_win(goal):
	if gold >= goal:
		print("WIN")
	else:
		print("LOSE")
