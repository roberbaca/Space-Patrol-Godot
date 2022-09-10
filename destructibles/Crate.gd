extends StaticBody2D

export (float) var hp = 30
onready var anim_player = $AnimationPlayer
onready var coll_shape = $CollisionShape2D
onready var camera_shake: Node = get_tree().current_scene.get_node("Player/Camera/Camera2D/ScreenShake")

export (PackedScene) var explosion: PackedScene = preload("res://enemy/Explosion.tscn")

func _process(delta):
	if hp == 0:
		coll_shape.disabled = true
		$HurtBox/CollisionShape2D.disabled = true
		camera_shake.start(2, 0.2, 15)
		anim_player.play("destroy")
		if not $SFXExplode.is_playing():
			$SFXExplode.play()

func _on_AnimationPlayer_animation_finished(anim_name):
	queue_free()


func _on_Area2D_area_entered(hitbox):
	if hitbox.name == "PlayerBullet":
		$SFXHit.play()
		hp -= hitbox.damage
		hitbox.destroy()
