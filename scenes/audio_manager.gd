extends Node

@onready var sfx_player = $SFXPlayer
@onready var music_player = $MusicPlayer

var is_transitioning := false

# SFX
var click_sfx = preload("res://assets/sfx/click.wav")
var success_sfx = preload("res://assets/sfx/success.wav")
var fail_sfx = preload("res://assets/sfx/fail.mp3")

# Music
#var main_music = preload("res://assets/music/night_theme_1.wav")
var music_tracks = [
	preload("res://assets/music/day_theme_1.wav"),
	preload("res://assets/music/day_theme_2.wav"),
	preload("res://assets/music/night_theme_1.wav"),
	preload("res://assets/music/night_theme_2.wav")
]

func _ready():
	play_random_music()

func play_sfx(sound):
	sfx_player.stream = sound
	sfx_player.play()

var current_music = null
var current_track = null

func play_music(music):
	if current_music == music and music_player.playing:
		return  # don't restart
	
	current_music = music
	music_player.stream = music
	music_player.play()

func play_random_music():
	if is_transitioning:
		return
	
	if music_tracks.is_empty():
		return

	is_transitioning = true
	
	var next_track = music_tracks.pick_random()

	# avoid same track twice in a row
	while next_track == current_track and music_tracks.size() > 1:
		next_track = music_tracks.pick_random()

	current_track = next_track
	
	var tween = create_tween()
	
	tween.tween_property(music_player, "volume_db", -30, 0.5)
	tween.tween_callback(func():
		music_player.stream = current_track
		music_player.play()
	)
	
	tween.tween_property(music_player, "volume_db", 0, 0.5)
	tween.tween_callback(func():
		is_transitioning = false
	)


func _on_music_player_finished() -> void:
	play_random_music()
