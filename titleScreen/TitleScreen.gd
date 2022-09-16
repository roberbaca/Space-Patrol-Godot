extends Control

func _ready():
	$Buttons/NewGame.grab_focus()
	if not MusicTitleScreen.is_playing():
		MusicTitleScreen.play()

func _on_FadeIn_fade_finished():
	get_tree().change_scene("res://levels/Level1.tscn")

func _on_NewGame_pressed():
	$SFXSelect.play()
	$FadeIn.show()
	$FadeIn.fade_in()

func _on_Quit_pressed():
	$SFXSelect.play()
	get_tree().quit()

func _on_Credits_pressed():
	$SFXSelect.play()
	get_tree().change_scene("res://menu/Credits/Credits.tscn")
