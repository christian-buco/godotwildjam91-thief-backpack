extends Panel

var current_npc = null
@onready var attempts_label = $AttemptsLabel
@onready var minigame_panel = $"../HBoxContainer/MinigamePanel"
var inventory

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	self.visible = false
	inventory = get_tree().get_first_node_in_group("inventory")

func show_encounter_ui():
	self.visible = true

func start_encounter(npc):
	if inventory.is_full():
		self.visible = true
		attempts_label.text = "INVENTORY IS FULL!"
		current_npc = npc
		$StealButton.disabled = true
	else:
		current_npc = npc
		self.visible = true
		attempts_label.text = "Steals Left: " + str(npc.steal_attempts)
	
func _on_steal_button_pressed() -> void:
	AudioManager.play_sfx(AudioManager.click_sfx)
	if current_npc:
		self.visible = false
		current_npc.attempt_steal()
		minigame_panel.enable_stop_button()


func _on_leave_button_pressed() -> void:
	AudioManager.play_sfx(AudioManager.click_sfx)
	if current_npc:
		current_npc.end_encounter()
		self.visible = false

func end_encounter():
	self.visible = false
	current_npc = null
