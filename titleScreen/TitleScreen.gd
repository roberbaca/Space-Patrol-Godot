extends Control

func _ready():
	$Buttons/NewGame.grab_focus()

func _on_FadeIn_fade_finished():
	get_tree().change_scene("res://levels/Level1.tscn")

func _on_NewGame_pressed():
	$FadeIn.show()
	$FadeIn.fade_in()

func _on_Quit_pressed():
	get_tree().quit()

func _on_Credits_pressed():
	get_tree().change_scene("res://menu/Credits/Credits.tscn")
