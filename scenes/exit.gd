extends Area2D

@export var gold_goal: int = 20

var game_controller

func _ready() -> void:
	game_controller = get_tree().get_first_node_in_group("game_controller")
	


func _on_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		body.stop_walking()
		game_controller.check_win(gold_goal)
