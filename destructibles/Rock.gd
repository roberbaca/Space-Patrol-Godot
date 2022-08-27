extends StaticBody2D

export (float) var hp = 100
onready var anim_player = $AnimationPlayer
onready var coll_shape = $CollisionShape2D
onready var camera_shake: Node = get_tree().current_scene.get_node("Player/Camera/Camera2D/ScreenShake")

var anim = randi() % 4

func _ready():
	match anim:
		0:
			anim_player.play("idle1")
		1:
			anim_player.play("idle2")
		2:
			anim_player.play("idle3")
		3:
			anim_player.play("idle4")

export (PackedScene) var explosion: PackedScene = preload("res://enemy/Explosion.tscn")

func _process(delta):
	if hp <= 0:
		coll_shape.disabled = true
		match anim:
			0:
				anim_player.play("destroy1")
				camera_shake.start(4, 0.5, 15)
			1:
				anim_player.play("destroy2")
				camera_shake.start(4, 0.5, 15)
			2:
				anim_player.play("destroy3")
				camera_shake.start(4, 0.5, 15)
			3:
				anim_player.play("destroy4")
				camera_shake.start(4, 0.5, 15)

func _on_Area2D_area_entered(hitbox):
	if hitbox.name == "PlayerBullet" or hitbox.name == "EnemyBullet":
		hp -= hitbox.damage
		hitbox.destroy()
		if hp > 0:
			match anim:
				0:
					anim_player.play("hit1")
				1:
					anim_player.play("hit2")
				2:
					anim_player.play("hit3")
				3:
					anim_player.play("hit4")


func _on_AnimationPlayer_animation_finished(anim_name):	
	if anim_name == "destroy1" or anim_name == "destroy2" or anim_name == "destroy3" or anim_name == "destroy4":
		queue_free()
