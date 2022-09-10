extends Control

func _on_Retry_pressed():
	Globals.restart_game()

func _on_Quit_pressed():
	get_tree().quit()
