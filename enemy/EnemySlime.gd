extends Entity

var path: PoolVector2Array
export var enemy_velocity = 1

onready var navigation: Navigation2D = get_tree().current_scene.get_node("Navigation2D")
onready var player: KinematicBody2D = get_tree().current_scene.get_node("Player")

func _process(delta):
	if hp > 0:
		chase()

func _on_EnemySlime_died():
	anim_player.play("death")

func _on_EnemySlime_hp_changed(new_hp):
	anim_player.play("hit")

func _on_AnimationPlayer_animation_finished(anim_name):
	if anim_name == "death":
		queue_free()
	elif anim_name == "hit":
		anim_player.play("move")

func chase():
	if path:
		var vector_to_next_point: Vector2 = path[0] - global_position
		var distance_to_next_point: float = vector_to_next_point.length()
		if distance_to_next_point < enemy_velocity: # cuando alcanzamos el sig punto, lo sacamos del array
			path.remove(0)
			if not path:
				return # si no hay mas puntos en el recorrido, return
		move_direction = vector_to_next_point
		
		# Animaciones
		if vector_to_next_point.x > 0 and animated_sprite.flip_h:
			animated_sprite.flip_h = false
		elif vector_to_next_point.x < 0 and not animated_sprite.flip_h:
			animated_sprite.flip_h = true

func _on_PathTimer_timeout():
	path = navigation.get_simple_path(global_position, player.position)
