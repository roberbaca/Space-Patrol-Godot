extends "res://overlap/Hitbox.gd"

export (int) var bullet_speed: int = 100
export (PackedScene) var hit_effect: PackedScene = preload("res://bullet/HitEffect.tscn")
onready var hit_effect_pos = $hit_pos

func _physics_process(delta):
	var direction = Vector2.RIGHT.rotated(rotation)
	global_position += bullet_speed * direction * delta

func destroy():
	var hit_effect_instance = hit_effect.instance()
	get_tree().current_scene.add_child(hit_effect_instance)
	hit_effect_instance.position = hit_effect_pos.global_position
	hit_effect_instance.rotation_degrees = self.rotation_degrees
	queue_free()

func _on_PlayerBullet_area_entered(area):
	destroy()

func _on_PlayerBullet_body_entered(body):
	destroy()


func _on_VisibilityNotifier2D_screen_exited():
	queue_free()
