extends Node2D

onready var camera_shake: Node = get_tree().current_scene.get_node("Player/Camera/Camera2D/ScreenShake")

func _ready():
	camera_shake.start()

func _on_AnimationPlayer_animation_finished(anim_name):
	queue_free()
