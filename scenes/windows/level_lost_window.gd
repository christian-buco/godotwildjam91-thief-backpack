@tool
extends OverlaidWindow

signal restart_pressed
signal main_menu_pressed

func _ready():
	if OS.has_feature("web"):
		%ExitButton.hide()

func _on_exit_button_pressed():
	AudioManager.play_sfx(AudioManager.click_sfx)
	%ExitConfirmation.show()

func _on_main_menu_button_pressed():
	AudioManager.play_sfx(AudioManager.click_sfx)
	%MainMenuConfirmation.show()

func _on_close_button_pressed():
	AudioManager.play_sfx(AudioManager.click_sfx)
	restart_pressed.emit()
	close()

func _on_main_menu_confirmation_confirmed():
	AudioManager.play_sfx(AudioManager.click_sfx)
	main_menu_pressed.emit()
	close()

func _on_exit_confirmation_confirmed():
	get_tree().quit()
