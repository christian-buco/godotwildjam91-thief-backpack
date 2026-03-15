extends Node

var items = []

func _ready():
	items = [
		Item.new("Coin", preload("res://assets/player.png"), 5)
	]
	
func get_random_item():
	return items.pick_random()
