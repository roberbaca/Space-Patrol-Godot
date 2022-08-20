extends "res://overlap/Hitbox.gd"

export (int) var bullet_speed: int = 100
export (PackedScene) var explosion: PackedScene = preload("res://bullet/Explosion.tscn")
onready var explosion_point = $explosion_point

func _physics_process(delta):
	var direction = Vector2.RIGHT.rotated(rotation)
	global_position += bullet_speed * direction * delta

func destroy():
	var exlosion_instance = explosion.instance()
	get_tree().current_scene.add_child(exlosion_instance)
	exlosion_instance.position = explosion_point.global_position
	exlosion_instance.rotation_degrees = self.rotation_degrees
	queue_free()

func _on_PlayerBullet_area_entered(area):
	destroy()

func _on_PlayerBullet_body_entered(body):
	destroy()


func _on_VisibilityNotifier2D_screen_exited():
	queue_free()
