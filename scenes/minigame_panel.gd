extends Panel

@export var bar_width := 400
@export var bar_height := 20

@export var base_needle_speed := 400
@export var base_green_ratio := 0.3
@export var base_yellow_ratio := 0.3
@export var needle_speed := 400
var direction := 1
var stealing := false
var result_callback:Callable

@onready var green_zone = $Bar/GreenZone
@onready var yellow_zone = $Bar/YellowZone
@onready var bar_bg = $Bar/BarBackground
@onready var needle = $Bar/Needle

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	bar_bg.size = Vector2(bar_width, bar_height)
	green_zone.size = Vector2(bar_width * base_green_ratio, bar_height)
	yellow_zone.size = Vector2(bar_width * base_yellow_ratio, bar_height)
	
	green_zone.position.x = (bar_width - green_zone.size.x) / 2
	yellow_zone.position.x = (bar_width - yellow_zone.size.x) / 2
	needle.position.x = bar_width / 2

func reset_difficulty():
	needle_speed = base_needle_speed
	green_zone.size.x = bar_width * base_green_ratio
	yellow_zone.size.x = bar_width * base_yellow_ratio
	green_zone.position.x = (bar_width - green_zone.size.x) / 2
	yellow_zone.position.x = (bar_width - yellow_zone.size.x) / 2

func apply_inventory_modifiers(items):
	var speed_bonus := 0.0
	var zone_penalty := 0.0
	
	for item in items:
		speed_bonus += item.speed_mod
		zone_penalty += item.zone_mod
		
	needle_speed = base_needle_speed * (1.0 + speed_bonus)
	
	var new_ratio = base_green_ratio * (1.0 + zone_penalty)
	new_ratio = clamp(new_ratio, 0.04, 0.5)
	
	green_zone.size.x = bar_width * new_ratio
	green_zone.position.x = (bar_width - green_zone.size.x) / 2

func apply_buff():
	green_zone.size.x = bar_width * 0.4

func apply_debuff():
	green_zone.size.x = bar_width * 0.1

func start_steal(callback):
	stealing = true
	needle.position.x = 0
	direction = 1
	result_callback = callback
	
func _process(delta: float) -> void:
	if !stealing:
		return
	needle.position.x += direction * needle_speed * delta
	if needle.position.x >= bar_bg.size.x:
		needle.position.x = bar_bg.size.x
		direction = -1
	elif needle.position.x <= 0:
		needle.position.x = 0
		direction = 1


func _on_stop_button_pressed() -> void:
	if stealing:
		finish_steal()

func enable_stop_button():
	$StopButton.disabled = false

func disable_stop_button():
	$StopButton.disabled = true


func finish_steal():
	stealing = false
	
	var green_start = green_zone.position.x
	var green_end = green_zone.position.x + green_zone.size.x
	
	if needle.position.x >= green_start and needle.position.x <= green_end:
		print("Perfect steal!")
		if result_callback:
			result_callback.call("perfect")
	else:
		print("Failed steal!")
		if result_callback:
			result_callback.call("fail")
	
