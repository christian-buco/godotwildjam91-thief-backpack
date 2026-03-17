extends CharacterBody2D

@export var speed := 100.0
@onready var game_controller = get_tree().get_first_node_in_group("game_controller")
var can_walk := true

func _physics_process(delta: float) -> void:
	if game_controller.is_game_over:
		velocity = Vector2.ZERO
		return
	if !can_walk:
		velocity = Vector2.ZERO
		move_and_slide()
		return
	
	velocity.x = speed
	move_and_slide()

func stop_walking():
	can_walk = false

func resume_walking():
	can_walk = true
