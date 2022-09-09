extends ColorRect

onready var logo = $Control/Logo
onready var tween = $Tween
onready var logo_text = $Control/RNBGames
onready var flick_sound = $LightFlickerSound

func _ready():
	flick_sound.play()
	tween.interpolate_property(logo_text, 'modulate', Color(1,1,1,0), Color(1,1,1,1), 1, Tween.TRANS_BOUNCE, Tween.EASE_IN_OUT)
	tween.start()

func _on_AnimationPlayTimer_timeout():
	logo.play()

func _on_ChangeSceneTimer_timeout():
	$FadeIn.show()
	$FadeIn.fade_in()
	
func _on_Logo_animation_finished():
	$ChangeSceneTimer.start()

func _on_FadeIn_fade_finished():
	get_tree().change_scene("res://titleScreen/TitleScreen.tscn")
