extends Area2D

var game_controller

func _ready() -> void:
	game_controller = get_tree().get_first_node_in_group("game_controller")
	


func _on_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		body.stop_walking()
		game_controller.check_win()
