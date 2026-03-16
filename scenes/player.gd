extends CharacterBody2D

@export var speed := 100.0
var can_walk := true

func _physics_process(delta: float) -> void:
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
