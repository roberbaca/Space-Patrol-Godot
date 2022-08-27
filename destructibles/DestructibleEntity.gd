extends StaticBody2D

export (float) var hp = 100
onready var anim_player = $AnimationPlayer
onready var coll_shape = $CollisionShape2D
onready var camera_shake: Node = get_tree().current_scene.get_node("Player/Camera/Camera2D/ScreenShake")

func _process(delta):
	if hp <= 0:
		coll_shape.disabled = true
		anim_player.play("destroy")
		camera_shake.start(4, 0.5, 15)

func _on_Area2D_area_entered(hitbox):
	if hitbox.name == "PlayerBullet":
		hp -= hitbox.damage
		hitbox.destroy()

func _on_AnimationPlayer_animation_finished(anim_name):	
	queue_free()
