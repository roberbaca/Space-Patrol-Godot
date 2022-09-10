extends StaticBody2D

func _on_AnimationPlayer_animation_finished(anim_name):
	queue_free()

func _on_Area2D_body_entered(body):
	if body.name == "Player" and Globals.enemies_killed == Globals.enemies_total:
		$AnimationPlayer.play("open")
