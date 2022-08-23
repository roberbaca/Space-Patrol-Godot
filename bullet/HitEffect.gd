extends AnimatedSprite

onready var anim_player = $AnimationPlayer

func _ready():
	anim_player.play("go")

func _on_AnimationPlayer_animation_finished(anim_name):
	queue_free()
